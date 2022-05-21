Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    resources :posts do
      resources :comments, only: [:destroy, :create]
      resource :likes, only: [:create, :destroy]
    end
    get "posts/likes" => "likes#index", as: "likes"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
