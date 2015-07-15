class MyApi2 < Grape::API
  format :json # mount MyApi1 しても、設定は引き継がれないため改めて書く必要がある
  prefix :api

  # curl http://localhost:3000/api/action3
  desc "コメント"
  get :action3 do
    {method_name => params}
  end

  mount MyApi1
end
