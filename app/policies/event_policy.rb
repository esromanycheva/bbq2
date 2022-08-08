class EventPolicy < ApplicationPolicy
  def initialize(user, record, access_token_context = nil)
    @access_token_context = access_token_context
    super(user, record)
  end

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
    @access_token_context.valid_token?
  end
end