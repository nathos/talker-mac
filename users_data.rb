#
# Storage for users present in a room
#

class UsersData < ApiStore

    attr_accessor :users, :view
    
    # Overwrite the fetch method from ApiStore
    def fetch(room_id)
        url = NSURL.URLWithString "#{host}/rooms/#{room_id}.json"
        request = ASIHTTPRequest.requestWithURL(url)
        request.setDelegate self
        request.addRequestHeader "X-Talker-Token", value:token
        request.startAsynchronous
    end

    # On success, parse users in the given room
    def requestFinished(request)
        data = JSON.parse(request.responseString)
        @users = data['users']
        puts @users
        view.reloadData
    end
    
    # Just explode if something bad happens
    def requestFailed(request)
        error = request.error
        raise "Error parsing the users API call"
    end    
    
    def numberOfRowsInTableView(view)
        @users ? @users.size : 0
    end
    
    def tableView(view, objectValueForTableColumn:column, row:index)
        @users[index]["name"]
    end

end
