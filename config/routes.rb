Rails.application.routes.draw do
  root "users#index"
  get "users/action1" => "users#action1"
  get "users/action2" => "users#action2"
  get "users/action3" => "users#action3"
end
