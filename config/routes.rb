Rails.application.routes.draw do
  resources :order_items
  resources :orders do
    collection do
      put :label
    end
  end
  devise_for :users
  get 'summary' => 'order_items#summary'
  get 'mailing' => 'orders#mailing'
  root 'orders#index'
end
