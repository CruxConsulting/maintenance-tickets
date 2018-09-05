module ApplicationHelper

  def ldate(dt, hash = {})
    dt ? l(dt, hash) : nil
  end

  def tech_visit_card_url(tech)
    root_url + image_url('logo.png')
  end

end
