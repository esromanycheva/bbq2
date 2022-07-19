module ApplicationHelper
  def user_avatar(user)
    if user.avatar_image.attached?
      user.avatar_image
    else
      asset_path('user.png')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar_image.attached?
      user.avatar_image.variant(resize: "200x200!")
    else
      asset_path('user.png')
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any? && photos.pluck(:photo).compact.present?
      rails_blob_path(photos.sample.photo_image.variant(:thumb), only_path: true)
    else
      asset_path('event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo_image.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
