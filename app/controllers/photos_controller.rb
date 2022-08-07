class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :check_photo, only: [:create]
  before_action :set_photo, only: [:destroy]
  before_action :authorize_photo!
  after_action :verify_authorized

  def create
    @new_photo = @event.photos.build(photo_params)

    @new_photo.user = current_user

    if @new_photo.save
      notify_subscribers(@new_photo)
      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.photos.destroyed')}

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t('controllers.photos.error')}
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo_image)
  end

  def check_photo
    if photo_params[:photo_image].nil?
      redirect_to @event, alert: 'Выберите фотографию'
    end
  end

  def notify_subscribers(photo)
    event = photo.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq

    all_emails.each do |mail|
      EventMailer.photo(photo, mail).deliver_now
    end
  end

  def authorize_photo!
    authorize(@photo || Photo)
  end
end
