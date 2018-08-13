module ApplicationHelper

  def current_class?(about_path)
    return 'active' if request.path == about_path
  end



end
