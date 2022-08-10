class EventPolicy < ApplicationPolicy
  def create?
    !user.guest?
  end

  def update?
    user.author?(record)
  end

  def edit?
    update?
  end

  def destroy?
    user.author?(record)
  end

  def index?
    true
  end

  def show?
    valid_token?(record)
  end

  private

  def valid_token?(event_context)
    return true if event_context.event.pincode.blank?
    return true if user && user == event_context.event.user
    event_context.pincode.present? && event_context.event.pincode == event_context.pincode
  end
end
