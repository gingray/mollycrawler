class CrawlerController < ApplicationController
  before_action :authenticate_user!
  def root
    @tasks = Task.all
  end
end
