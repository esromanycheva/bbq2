class GuestUser
  def guest?
    true
  end

  def author?(_)
    false
  end
end