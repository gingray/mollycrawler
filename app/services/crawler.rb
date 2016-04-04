class Crawler

  def initialize task
    @task = task
    @processor = task.processor.constantize
  end

  def fetch url
    response = request url
    parse url, response.body
  end

  def parse url, data
    router = ActionRouter.new url, data, @processor.routes
    router.action @task
  end

  def request url
    tries ||= 0
    conn.get url
  rescue
    if (tries+=1) <=4
      retry
    else
      raise
    end
  end

  def conn
    @conn = Mechanize.new do |agent|
      agent.user_agent_alias =  'Windows Mozilla'
      proxy = Proxy.first
      if proxy
        agent.set_proxy proxy.address, proxy.port, proxy.username, proxy.password
        proxy.touch
      end
    end
    @conn
  end
end
