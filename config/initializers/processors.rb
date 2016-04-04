Dir[File.expand_path "#{Rails.root}/app/services/processors/**/*.rb"]
    .select { |f| f =~ /processor/}
    .each { |f| require f }

