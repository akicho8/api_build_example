class MyApi < Grape::API
  # version 'v1', using: :header, vendor: 'twitter' # ？
  format :json
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

  # curl http://localhost:3000/api/action3
  desc "コメント"
  get :action3 do
    Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :action3]
    "(action3)"
  end

  # curl -X PUT -d foo http://localhost:3000/api/action5
  desc "コメント"
  put :action5 do
    "(action5)"
  end

  # curl -X PUT -d foo http://localhost:3000/api/action6
  desc "コメント"
  delete :action6 do
    "(action6)"
  end

  resource :sub_ns do
    # curl http://localhost:3000/api/sub_ns/action4
    desc "ネームスペース付き."
    get :action4 do
      "(action4)"
    end

    # curl http://localhost:3000/api/sub_ns/1
    # curl http://localhost:3000/api/sub_ns/x           {"error":"id is invalid"}
    desc "Return a status."
    params do
      requires :id, type: Integer, desc: "User id."
    end
    route_param :id do
      get do
        params
      end
    end
  end
end

# class MyApi < MyApi0
#   # curl http://localhost:3000/api/action3
#   desc "コメント"
#   get :action3 do
#     "(action3) #{helper_method1}"
#   end
# end
