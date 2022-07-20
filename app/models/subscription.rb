class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :ban_subscriptions_to_own_event
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
              uniqueness: { scope: :event_id }
    validate :cannot_use_someone_email
  end

  validates :event, presence: true

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def cannot_use_someone_email
    errors.add(:user_email, :wrong_email) if User.exists?(email: user_email)
  end

  def ban_subscriptions_to_own_event
    errors.add(:user_email, :creator_cant_subscribe) if event.user == user
  end
end
