#
# Abstract store, keeps utility methods for requests and collections
#

class ApiStore

    attr_accessor :settings
    
    def initialize
        #"http://asdasdasda.lvh.me"
        #"10515607f1fcd30df8070a5bd7d5259843862f68"
    end

    def fetch
        url = NSURL.URLWithString "#{settings.host}#{path}"
        puts "Requesting #{settings.host}#{path}"
        request = ASIHTTPRequest.requestWithURL(url)
        request.setDelegate self
        request.addRequestHeader "X-Talker-Token", value:settings.token
        request.startAsynchronous
    end

end