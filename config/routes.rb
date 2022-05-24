Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    post "search_result" => "homes#search", as: "search"
    resources :posts do
      resources :comments, only: [:destroy, :create]
      resource :likes, only: [:create, :destroy]
    end
    get "users/my_page" => "users#show", as: "my_page"
    get "users/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    patch "users/withdraw" => "users#withdraw", as: "withdraw"
    resources :users, only: [:edit,:update] do
      member do
        get :posts
      end
      collection do
        get :likes
      end
    end
    get "tags/:tag_id/posts" => "tags#search", as: "tag_search"
  end

end
