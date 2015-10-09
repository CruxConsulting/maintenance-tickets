module ApplicationHelper

  def tech_visit_card_url(tech)
    filename = "carte-#{I18n.transliterate(tech).downcase}.jpg"
    root_url + image_path(filename)
  end

end
