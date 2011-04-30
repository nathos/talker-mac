#
# Abstract store, keeps utility methods for requests and collections
#

class ApiStore

    attr_accessor :host, :token
    
    def initialize
        @host = "http://asdasdasda.lvh.me"
        @token = "10515607f1fcd30df8070a5bd7d5259843862f68"
    end

    def fetch
        url = NSURL.URLWithString "#{host}#{path}"
        request = ASIHTTPRequest.requestWithURL(url)
        request.setDelegate self
        request.addRequestHeader "X-Talker-Token", value:token
        request.startAsynchronous
    end

end