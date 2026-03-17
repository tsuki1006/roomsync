module PageDetectionHelper

  def controller_action?(controller, action = 'show')
    controller_name == controller && action.include?(action_name)
  end

  def add_active_class(path)
    path = path.split('?').first # remove path after ?
    'active' if current_page?(path)
  end

  def add_active_class_2(controller, action)
    'active' if controller_action?(controller, action)
  end
end
