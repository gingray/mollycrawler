class ProcessorBase
  def process hash
    task, data = create_task hash
    run task, data
  end


  def self.name
    raise 'set processor name'
  end

  def self.routes
    raise 'implement router'
  end

  private
  def run task, data
    raise 'implement this method'
  end

  def create_task hash
    raise 'implement this method'
  end
end
