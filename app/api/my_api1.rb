class MyApi1 < Grape::API
  # version 'v1', using: :header, vendor: 'twitter' # ？
  format :json
  formatter :json, Grape::Formatter::Rabl

  content_type :msgpack, 'application/x-msgpack'
  default_format :msgpack

  prefix :api

  helpers do
    # def authenticate!
    #   error!('401 Unauthorized', 401) unless current_user
    # end

    def helper_method1
      __method__
    end
  end

  # before            { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :before] }
  # before_validation { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :before_validation] }
  # after_validation  { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :after_validation] }
  # after             { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :after] }

  # curl http://localhost:3000/api/hello
  desc "コメント"
  get :hello do
    {method_name => params}
  end

  # curl http://localhost:3000/api/action3
  desc "コメント"
  get :action3 do
    {:foo => "(これは表示されない)"}
  end

  # curl http://localhost:3000/api/action7
  desc "コメント"
  get :action7, :rabl => "my_api/action7" do
  end

  # curl -X PUT -d foo http://localhost:3000/api/action5
  desc "コメント"
  put :action5 do
    {method_name => params}
  end

  # curl -X PUT -d foo http://localhost:3000/api/action6
  desc "コメント"
  delete :action6 do
    {method_name => params}
  end

  # curl -X GET -H "Content-Type: application/x-msgpack" http://localhost:3000/api/action8
  # content_type 'application/x-msgpack'
  # raise Grape::ContentTypes::CONTENT_TYPES[:msgpack].inspect
  get :action8 do
    env['api.format'] = :msgpack
    {method_name => params, "api.format" => env['api.format']}
  end

  resource :subapi do
    # curl http://localhost:3000/api/subapi/action4
    desc "ネームスペース付き."
    get :action4 do
      {method_name => params}
    end

    # curl http://localhost:3000/api/subapi/1
    # curl http://localhost:3000/api/subapi/x           {"error":"id is invalid"}
    desc "Return a status."
    params do
      requires :id, type: Integer, desc: "User id."
    end
    route_param :id do
      get do
        {method_name => params}
      end
    end
  end
end
