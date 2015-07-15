Rails.application.routes.draw do
  root "users#index"
  get "users/action1a" => "users#action1a"
  get "users/action2" => "users#action2"
  get "users/action1" => "users#action1"

  mount MyApi2 => '/'
end
