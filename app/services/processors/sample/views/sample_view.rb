class Sample::Views::SampleView < ViewBase
  def get_links
    Task.where type_name: 'main', processor: SampleProcessor.to_s
  end

  def generate_file task, root_path
    path = "#{root_path}/#{task.tid}.csv"
    headers = ['title', 'url'
              ]
    CSV.open(path, "w+", write_headers: true, headers: headers) do |csv|
      task.children.find_each(start: 0, batch_size: 5000) do |sub_task|
        hash = sub_task.meta
        hash[:titles].zip(hash[:urls]).each do |arr|
          line = [ arr[0], arr[1] ]
          csv << line
        end
      end
    end
    path
  end
end
