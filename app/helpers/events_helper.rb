module EventsHelper
  def event_owner?(event)
    user_signed_in? && event.user == current_user
  end
end
