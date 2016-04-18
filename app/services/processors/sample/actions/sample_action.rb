class Sample::SampleAction < ActionBase
  def process url, data
    items = @doc.css('p.title a.title')
    @hash = {}
    @hash[:urls] = items.map { |item| item.attributes['href'].value }
    @hash[:titles] = items.map { |item| item.text }
  end

  def check_action? url, data
    @doc = Nokogiri::HTML(data)
    true
  end

  def after_action task
    task.create_sub_task meta: @hash
  end
end
