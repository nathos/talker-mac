
class RoomsData < ApiStore

    attr_accessor :rooms
    
    def fetch
        url = NSURL.URLWithString "#{host}/rooms.json"
        request = ASIHTTPRequest.requestWithURL url
        request.addRequestHeader "X-Talker-Token", value:token
        
        request.startSynchronous
        error = request.error
        if !error
            response = request.responseString
            @rooms = JSON.parse(response)
            @rooms = @rooms.each do |room|
                room["url"] = "#{host}/rooms/#{room['id']}"
            end
        end
    end
    
    def numberOfRowsInTableView(view)
        @rooms ? @rooms.size : 0
    end
    
    def tableView(view, objectValueForTableColumn:column, row:index)
        @rooms[index]["name"]
    end

end