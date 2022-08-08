class AccessTokenContextPolicy < ApplicationPolicy
  def initialize(current_user, access_token_context)
    @current_user = current_user
    @access_token_context = access_token_context
  end

  def show?
    @access_token_context.valid_token?
  end
end