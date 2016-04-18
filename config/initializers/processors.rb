Dir[File.expand_path "#{Rails.root}/app/services/processors/*/", __FILE__].each do |dir|
  Object.class_eval "module #{File.basename(dir).camelize}; end";
end

Dir[File.expand_path "#{Rails.root}/app/services/processors/**/*.rb", __FILE__].each { |f| require f }


