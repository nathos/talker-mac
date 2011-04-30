
class UsersData

    def fetch(room_id)
        url = NSURL.URLWithString "https://teambox.talkerapp.com/rooms/#{room_id}.json"
        request = ASIHTTPRequest.requestWithURL url
        request.addRequestHeader "X-Talker-Token", value:"ea275113713187301a1f520c5772658f4cf617c6"
        
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
