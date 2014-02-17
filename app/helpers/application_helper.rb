module ApplicationHelper
  
  def is_admin?
    current_user && current_user.is_admin?
  end

  def user_name
    user_name = current_user.first_name.blank? ? "User ##{current_user.id}" : current_user.first_name
  end

  def key_maker(str)
    Digest::MD5.hexdigest(str)
  end
  
end
