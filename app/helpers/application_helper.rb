module ApplicationHelper

  def region_selected(object)
    object.region ? object.region : '--'
  end
end
