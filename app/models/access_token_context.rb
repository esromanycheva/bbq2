class AccessTokenContext

  attr_reader :user, :record, :token

  def initialize(user, record, token = '')
    @user = user
    @record = record
    @token = token
  end

  def valid_token?
    return true if record.pincode.blank?
    return true if user && user == record.user
    @valid_token ||= token.present? && record.pincode == token
  end
end
