#
# Handles the login window
#

class LoginController

    attr_accessor :app, :loginWindow, :submitButton
    attr_accessor :hostField, :tokenField
    attr_accessor :roomsData, :usersData

    # Load default values for now...
    def awakeFromNib
        hostField.stringValue = "https://teambox.talkerapp.com"
        tokenField.stringValue = "2e89c60a3d981e996b8bd1a173be273acfa52d14"
    end
    
    def performClick(sender)
        # Dirty: I'm assigning to each ApiStore, this should be a global setting
        roomsData.host = hostField.stringValue
        roomsData.token = tokenField.stringValue
        usersData.host = hostField.stringValue
        usersData.token = tokenField.stringValue
        app.stopModal
        loginWindow.close
    end

    # TODO: If I close the modal window, I can't quit the app :/

end