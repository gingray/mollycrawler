class WorkerBase
  include Sidekiq::Worker

  def perform task_id, url
    task = Task.find task_id
    crawler = Crawler.new task
    crawler.fetch url
  end
end

