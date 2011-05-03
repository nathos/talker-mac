#
# Storage for rooms in my account
#

class RoomsData

    attr_accessor :settings
    attr_accessor :rooms, :view, :settings

    # Fetch all the rooms for the current user
    def fetch
        url = NSURL.URLWithString "#{settings.host}/rooms.json"
        puts "Requesting #{settings.host}/rooms.json"
        request = ASIHTTPRequest.requestWithURL(url)
        request.setDelegate self
        request.addRequestHeader "X-Talker-Token", value:settings.token
        request.startAsynchronous
    end

    # On success, parse rooms
    def requestFinished(request)
        @rooms = JSON.parse(request.responseString)
        # Add URL parameter to be loaded in the WebView
        @rooms = @rooms.each do |room|
            room["url"] = "#{settings.host}/rooms/#{room['id']}?layout=chat_only"
        end
        view.reloadData
    end
    
    # Just explode if something bad happens
    def requestFailed(request)
        error = request.error
        raise "Error parsing the rooms API call"
    end    

    def numberOfRowsInTableView(view)
        @rooms ? @rooms.size : 0
    end
    
    def tableView(view, objectValueForTableColumn:column, row:index)
        @rooms[index]["name"]
    end

end