#
# Handles the sidebar (rooms and users)
#

class SidebarController

    attr_accessor :webFrame, :roomsView, :usersView
    attr_accessor :usersData, :roomsData
  
    # Initialize the app...
    def awakeFromNib
        # TODO: Autoload a room
    end

    # Clicking on rooms will change the active room
    def tableViewSelectionDidChange(notification)
        room = roomsData.rooms[roomsView.selectedRow]
        webFrame.mainFrame.loadHTMLString "<p style='font-family: Verdana;'>Loading...</p>", baseURL:nil
        webFrame.mainFrameURL = room["url"]
        webFrame.setHidden true
        usersData.fetch(room["id"])
    end

end
