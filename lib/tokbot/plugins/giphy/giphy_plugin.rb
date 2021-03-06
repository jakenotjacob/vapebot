require 'json'
class Giphy < Tokbot::Plugin
  PUBLIC_API_KEY = "dc6zaTOxFJmzC"
  URL = "http://api.giphy.com/v1/gifs/"
  attr_reader :tags
  def initialize(args)
    @tags = args
    puts tags
  end

  def self.new(args=nil)
    if args
      super
    else
      "Usage: '!giphy a b c'"
    end
  end

  def execute
    random
  end

  def response
    Net::HTTP.get URI(URL+api_str+"&"+tag_list)
  end

  def random
    JSON.parse(response)["data"]["url"]
  end

  #---

  def api_str
    "api_key=#{PUBLIC_API_KEY}"
  end

  def tag_list
    "tag=#{@tags.join("+")}"
  end

  #Parse json response
  def parse_json
    JSON.parse(get_json)
  end

end

