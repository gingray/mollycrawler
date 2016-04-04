class Proxy < ActiveRecord::Base

  def self.show_proxy
    Proxy.all.map do |proxy|
      val = "#{proxy.address}:#{proxy.port}"
      if proxy.username || proxy.password
        val = "#{val}:#{proxy.username}:#{proxy.password}"
      end
      val
    end.join "\n"
  end
end
