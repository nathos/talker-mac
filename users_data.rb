
class UsersData < ApiStore

    def fetch(room_id)
        url = NSURL.URLWithString "#{host}/rooms/#{room_id}.json"
        request = ASIHTTPRequest.requestWithURL url
        request.addRequestHeader "X-Talker-Token", value:token
        
        request.startSynchronous
        error = request.error
        if !error
            response = request.responseString
            data = JSON.parse(response)
            @users = data['users']
            puts @users
        end
    end

    def numberOfRowsInTableView(view)
        @users ? @users.size : 0
    end
    
    def tableView(view, objectValueForTableColumn:column, row:index)
        @users[index]["name"]
    end

end
