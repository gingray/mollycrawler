namespace :parser do
  desc "generate new parser"
  task :generate, [:name]  do |t, args|

  @action_template = <<-eos
class %{namespace}::%{namespace}Parser < ActionBase
  def process url, data
  end

  def check_action? url, data
  end

  def after_action task
  end
end
  eos

  @view_template = <<-eos
class %{namespace}::View < ViewBase
  def get_links
    #Task.where type_name: 'main', processor: SampleProcessor.to_s
  end

  def generate_file task, root_path
    path = "\#{root_path}/\#{task.tid}.csv"
    headers = []
    CSV.open(path, "w+", write_headers: true, headers: headers) do |csv|
      task.children.find_each(start: 0, batch_size: 5000) do |sub_task|
        hash = sub_task.meta
        #csv << line
      end
    end
    path
  end
end
  eos

  @worker_template = <<-eos
class %{namespace}::Worker < WorkerBase
  sidekiq_options queue: :default
end
  eos

  @processor_template = <<-eos
class %{namespace}::Processor < ProcessorBase
  def run task, data
  end

  def create_task hash
    # data = hash[:data]
    # task = Task.create! type_name: 'main', tid: hash[:tid], processor: self.class.to_s, meta: { site: data }
    # [task, data]
  end

  def self.name
    'pass name'
  end

  def self.routes
    [%{namespace}::%{namespace}Parser.new]
  end
end
  eos

    path = File.join Rails.root, "app", "services", "processors", "#{ARGV[-1]}"
    action_path = File.join path, "actions"
    views_path = File.join path, "views"
    workers_path = File.join path, "workers"
    Rake::FileUtilsExt.verbose false
    mkdir_p [action_path, views_path, workers_path]

    file_paths = [File.join(action_path, "page_parser.rb"), File.join(views_path, "view.rb"), File.join(workers_path, "worker.rb"), File.join(path, "processor.rb")]
    file_paths.zip([@action_template, @view_template, @worker_template, @processor_template]) do |path, template|
      next if File.exists? path
      File.open(path, 'w+') do |file|
        file.write template % { namespace: ARGV[-1].split('_').collect(&:capitalize).join }
      end
    end

    puts "parser generate in #{path}"
    exit
  end
end

