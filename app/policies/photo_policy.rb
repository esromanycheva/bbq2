class PhotoPolicy < ApplicationPolicy
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
    true
  end
end