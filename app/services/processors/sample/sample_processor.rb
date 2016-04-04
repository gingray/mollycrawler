class Sample::SampleProcessor < ProcessorBase
  def run task, data
    data.each { |item| SampleWorker.perform_async task.id, item }
  end

  def create_task hash
    data = hash[:data].gsub("\r", "").split("\n").map &:strip
    task = Task.create! type_name: 'main', tid: hash[:tid], processor: self.class.to_s, meta: { urls: data }
    [task, data]
  end

  def self.name
    'sample reddit parser'
  end

  def self.routes
    [SampleAction.new]
  end
end
