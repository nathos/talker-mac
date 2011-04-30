#
# Storage for rooms in my account
#

class RoomsData < ApiStore

    attr_accessor :rooms, :view

    # Path for the #fetch method
    def path
        "/rooms.json"
    end

    # On success, parse rooms
    def requestFinished(request)
        @rooms = JSON.parse(request.responseString)
        # Add URL parameter to be loaded in the WebView
        @rooms = @rooms.each do |room|
            room["url"] = "#{host}/rooms/#{room['id']}?layout=chat_only"
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