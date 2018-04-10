module ApplicationHelper
  def flash_class(level)
    case level
      when :notice  then "alert alert-info"
      when :success then "alert alert-success"
      when :error   then "alert alert-error"
    end
  end

  def current_path
    request.path
  end

  def nav_bar
    return "layouts/nav_visitor" if current_user.nil?

    case current_user.role
      when "default" then "layouts/nav_user"
      when "admin"   then "layouts/nav_admin"
    end
  end
end
