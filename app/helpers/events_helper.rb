module EventsHelper
  def show_subscription_button?
    @event.user != current_user && !@event.subscriptions.find_by(user: current_user)
  end
end
