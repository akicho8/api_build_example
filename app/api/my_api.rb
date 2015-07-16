class MyApi < Grape::API
  default_format :msgpack       # 何も指定がなければ msgpack で返す
  # format :json                # json を使う

  formatter :msgpack, Grape::Formatter::Rabl # msgpack で返すことになったときは Grape::Formatter::Rabl を使う
  formatter :json,    Grape::Formatter::Rabl # json で返すことになったときは Grape::Formatter::Rabl を使う

  # raise Grape::ContentTypes::CONTENT_TYPES.inspect
  # content_type :msgpack, 'application/x-msgpack'
  # raise Grape::ContentTypes::CONTENT_TYPES.inspect

  prefix :api

  helpers do
    def debug_hash
      {method_name => params, "api.format" => env['api.format']}
    end
  end

  # before            { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :before] }
  # before_validation { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :before_validation] }
  # after_validation  { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :after_validation] }
  # after             { Rails.logger.debug ["#{__FILE__}:#{__LINE__}", __method__, :after] }

  # curl -X GET    -d "" http://localhost:3000/api/get_action
  # curl -X PUT    -d "" http://localhost:3000/api/put_action
  # curl -X DELETE -d "" http://localhost:3000/api/delete_action
  get(:get_action)       { debug_hash }
  put(:put_action)       { debug_hash }
  delete(:delete_action) { debug_hash }

  get(:force_msgpack_rabl, :rabl => "rabl_inspect") { env['api.format'] = :msgpack }
  get(:force_json_rabl,    :rabl => "rabl_inspect") { env['api.format'] = :json    }

  get(:force_msgpack) { env['api.format'] = :msgpack; debug_hash }
  get(:force_json)    { env['api.format'] = :json;    debug_hash }

  resource :sub do
    # curl http://localhost:3000/api/sub/hello
    get(:hello) { debug_hash }

    # curl http://localhost:3000/api/sub/1
    # curl http://localhost:3000/api/sub/x           {"error":"id is invalid"}
    desc "Return a status."
    params do
      requires :id, type: Integer, desc: "User id."
    end
    route_param :id do
      get do
        debug_hash
      end
    end
  end

  # # format :json # mount MyApi1 しても、設定は引き継がれないため改めて書く必要がある
  # # prefix :api
  # #
  # # # curl http://localhost:3000/api/action3
  # # desc "コメント"
  # # get :action3 do
  # #   debug_hash
  # # end
  # #
  # mount MyApi1
end
