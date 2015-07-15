class ApiList
  include StaticRecord
  static_record [
    {:url => "/users/action1.json", :format => :json,    :url_method => "GET",    :desc => "action1.json.jbuilder で返せる",                    },
    {:url => "/users/action2.json", :format => :json,    :url_method => "GET",    :desc => "action2.json.rabl で返せる",                        },
    {:url => "/api/action3",        :format => :json,    :url_method => "GET",    :desc => "Grape の機能で既存APIを上書きできる",               },
    {:url => "/api/hello",          :format => :json,    :url_method => "GET",    :desc => "Grape の機能だけで返す",                            },
    {:url => "/api/subapi/action4", :format => :json,    :url_method => "GET",    :desc => "Grape の機能でネームスペースが作れる",              },
    {:url => "/api/action5",        :format => :json,    :url_method => "PUT",    :desc => "Grape の機能で PUT の API が作れる",                },
    {:url => "/api/action6",        :format => :json,    :url_method => "DELETE", :desc => "Grape の機能で DELETE の API が作れる",             },
    {:url => "/api/action7",        :format => :json,    :url_method => "GET",    :desc => "Grape + Rabl を使って action7.rabl のビューで返す", },
    {:url => "/api/action8",        :format => :msgpack, :url_method => "GET",    :desc => "Grape + Msgpack で返す",                            },
  ], :attr_reader => [:url, :format, :url_method, :desc]

  def ret_http_code
    ret_val("http_code")
  end

  def ret_content_type
    ret_val("content_type")
  end

  def ret_body_command
    "curl -s -X #{url_method} http://localhost:3000#{url}"
  end

  def ret_body
    `#{ret_body_command}`
  end

  def ret_head_status
    `curl -s -o /dev/null -I http://localhost:3000#{url} -w '%{http_code}'`
  end

  def ret_val(key)
    `curl -s -o /dev/null -X #{url_method} -w '%{#{key}}' http://localhost:3000#{url}`
  end
end
