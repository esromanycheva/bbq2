class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  after_action :verify_authorized, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    pincode = params[:pincode] || cookies.permanent["events_#{@event.id}_pincode"]

    event_context = EventContext.new(event: @event, pincode: pincode)
    authorize event_context, policy_class: EventPolicy

    cookies.permanent["events_#{@event.id}_pincode"] = pincode

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
    authorize @event
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
    authorize @event
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    authorize @event
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

  def set_event
    @event = Event.find(params[:id])
  end
end
