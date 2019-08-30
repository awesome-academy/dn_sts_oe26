module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "layouts.application.title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end
  def load_name name, day
    full_name = name + " ( " + day.to_s + "days )"
  end
end
