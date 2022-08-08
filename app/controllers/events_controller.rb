class EventsController < ApplicationController
  before_action :authorize_event!, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    authorize access_token_context

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  rescue Pundit::NotAuthorizedError
    render_password_form
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    redirect_to events_url, status: :see_other,  notice: I18n.t('controllers.events.destroyed')
  end

  private

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def render_password_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end

  def access_token_context
    @access_token_context ||=
      AccessTokenContext.new(current_user, event, params[:pincode])
  end

  def authorize_event!
    authorize event
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
