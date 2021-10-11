# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost:3001'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %i[show]
    resources :channels, only: %i[index] do
      member do
        resources :chat_messages, only: %i[create index]
      end
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/login',
               sign_out: 'api/logout',
               registration: 'api/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
