#
# Handles the sidebar (rooms and users)
#

class SidebarController

    attr_accessor :webView, :roomsView, :usersView
    attr_accessor :usersData, :roomsData
  
    # Initialize the app...
    def awakeFromNib
        roomsData.fetch
        # TODO: Autoload a room
    end

    # Clicking on rooms will change the active room
    def tableViewSelectionDidChange(notification)
        room = roomsData.rooms[roomsView.selectedRow]
        webView.mainFrameURL = room["url"]
        usersData.fetch(room["id"])
    end

end
