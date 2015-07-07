Rails.application.routes.draw do

    match '/apps', to: 'apps#index', via: :get, as: :apps
    match '/fetch', to: 'apps#fetch', via: :get, as: :apps_fetch

    match '/reviews', to: 'reviews#index', via: :get, as: :reviews
    match '/reviews/:id', to: 'reviews#show', via: :get, as: :show_reviews


end
