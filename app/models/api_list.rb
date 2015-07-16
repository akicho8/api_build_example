class ApiList
  include StaticRecord
  static_record [
    {:url => "/users/action1.json",     :format => :json,    :url_method => "GET",    :desc => "Rails のみ, action1.json.jbuilder, Grape未使用", },
    {:url => "/users/action2.json",     :format => :json,    :url_method => "GET",    :desc => "action2.json.rabl, Grape未使用, rablだけ利用",   },
    {:url => "/api/get_action",         :format => nil,      :url_method => "GET",    :desc => "Grape (default_format)",                         },
    {:url => "/api/get_action.xml",     :format => :xml,     :url_method => "GET",    :desc => "Grape .xml",                                  },
    {:url => "/api/get_action.txt",     :format => :txt,     :url_method => "GET",    :desc => "Grape .txt",                                  },
    {:url => "/api/get_action.json",    :format => :json,    :url_method => "GET",    :desc => "Grape .json",                                   },
    {:url => "/api/get_action.msgpack", :format => :msgpack, :url_method => "GET",    :desc => "Grape .msgpack",                                   },
    {:url => "/api/put_action",         :format => nil,      :url_method => "PUT",    :desc => "Grape で PUT",                                   },
    {:url => "/api/delete_action",      :format => nil,      :url_method => "DELETE", :desc => "Grape で DELETE",                                },
    {:url => "/api/force_msgpack_rabl", :format => :msgpack, :url_method => "GET",    :desc => "Grape + msgpack + rabl",                         },
    {:url => "/api/force_json_rabl",    :format => :json,    :url_method => "GET",    :desc => "Grape + json + rabl",                            },
    {:url => "/api/force_msgpack",      :format => :msgpack, :url_method => "GET",    :desc => "Grape + msgpack",                                },
    {:url => "/api/force_json",         :format => :json,    :url_method => "GET",    :desc => "Grape + json",                                   },
    {:url => "/api/sub/hello",          :format => nil,      :url_method => "GET",    :desc => "Grape + namespace",                              },
  ], :attr_reader => [:url, :format, :url_method, :desc]

  def ret_http_code
    ret_val("http_code")
  end

  def ret_content_type
    ContentType.parse(ret_val("content_type")).subtype
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
