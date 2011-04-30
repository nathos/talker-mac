
class RoomsData

    attr_accessor :rooms
    
    def fetch
        url = NSURL.URLWithString "https://teambox.talkerapp.com/rooms.json"
        request = ASIHTTPRequest.requestWithURL url
        request.addRequestHeader "X-Talker-Token", value:"ea275113713187301a1f520c5772658f4cf617c6"
        
        request.startSynchronous
        error = request.error
        if !error
            response = request.responseString
            @rooms = JSON.parse(response)
            @rooms = @rooms.each do |room|
                room["url"] = "https://teambox.talkerapp.com/rooms/#{room['id']}"
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