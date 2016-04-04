require 'sidekiq/web'

Rails.application.routes.draw do

  root 'crawler#root'
  devise_for :users

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
