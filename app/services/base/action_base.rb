class ActionBase
  def process url, data
    raise 'implement this method'
  end

  def check_action? url, data
    #check if action fit to data
    raise 'implement this method'
  end

  def after_action task
    #save data here
  end
end
