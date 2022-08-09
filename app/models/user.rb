class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :github]

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create
  before_validation :set_email, on: :create

  after_commit :link_subscriptions, on: :create

  has_one_attached :avatar_image, service: :yandex do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  def self.find_for_github_oauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.find_for_vkontakte_oauth(access_token)
    email = access_token.info.email

    user = where(email: email).first
    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "http://vk.com/id#{id}"
    name = access_token.info.name

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = name
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  def guest?
    false
  end

  def author?(obj)
    obj.user == self
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    user ||= User.create(
      email: data["email"],
      password: Devise.friendly_token[0, 20]
    )

    user.name = access_token.info.name
    user.image = access_token.info.image
    user.provider = access_token.provider
    user.uid = access_token.uid
    user.save

    user
  end

  private

  def set_name
    self.name = "Товарищ №#{rand(777)}" if self.name.blank?
  end

  def set_email
    self.email = "change@me.example" if self.email.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
