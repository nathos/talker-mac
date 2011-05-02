#
# Handles the login window
#

class LoginController

    attr_accessor :app, :loginWindow, :submitButton
    attr_accessor :hostField, :tokenField
    attr_accessor :roomsData, :usersData

    # Load default values for now...
    def awakeFromNib
        # Try to use the same password as last time
        prefs = NSUserDefaults.standardUserDefaults
        hostField.stringValue = prefs.stringForKey("host") || "https://youraccount.talkerapp.com"
        tokenField.stringValue = prefs.stringForKey("token") || "your_api_token"
        
        # Make it so when pressing <return> the login form gets submitted
        hostField.action = "performClick:"
        tokenField.action = "performClick:"
    end
    
    def performClick(sender)
        # Dirty: I'm assigning to each ApiStore, this should be a global setting
        roomsData.host = hostField.stringValue
        roomsData.token = tokenField.stringValue
        usersData.host = hostField.stringValue
        usersData.token = tokenField.stringValue
        
        # Save settings to preferences
        prefs = NSUserDefaults.standardUserDefaults
        prefs.setObject hostField.stringValue, forKey:"host"
        prefs.setObject tokenField.stringValue, forKey:"token"

        # Return focus to main window
        app.stopModal
        loginWindow.close
    end

    # TODO: If I close the modal window, I can't quit the app :/

end