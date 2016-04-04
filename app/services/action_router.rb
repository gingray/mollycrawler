class ActionRouter
  def initialize url, data, actions
    @url, @data, @actions = url, data, actions
  end

  def action state
    item = @actions.find { |e| e.check_action? @url, @data }
    result = item.process @url, @data
    item.after_action state
    result
  end
end
