
class SidebarController

    attr_accessor :webView, :roomsView, :usersView
    attr_accessor :usersData, :roomsData
  
    # Initialize the app...
    def awakeFromNib
        populate_sidebar
    end

    def populate_sidebar
        roomsData.fetch
        usersData.fetch(819)
    end

    # Clicking on rooms will change the active room
    def tableViewSelectionDidChange(notification)
        room = roomsData.rooms[roomsView.selectedRow]
        webView.mainFrameURL = room["url"]
        usersData.fetch(room["id"])
        usersView.reloadData
    end

end
