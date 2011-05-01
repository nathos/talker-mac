#
# Handles the sidebar (rooms and users)
#

class SidebarController

    attr_accessor :webView, :roomsView, :usersView
    attr_accessor :usersData, :roomsData
  
    # Initialize the app...
    def awakeFromNib
        #roomsData.fetch
        # TODO: Autoload a room
    end

    # Clicking on rooms will change the active room
    def tableViewSelectionDidChange(notification)
        room = roomsData.rooms[roomsView.selectedRow]
        webView.mainFrame.loadHTMLString "Loading...", baseURL:nil
        webView.mainFrameURL = room["url"]
        webView.setHidden true
        usersData.fetch(room["id"])
    end

end
