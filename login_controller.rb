#
# Handles the login window
#

class LoginController

    attr_accessor :app, :loginWindow, :submitButton, :spinner, :errorMsg
    attr_accessor :hostField, :tokenField
    attr_accessor :roomsData, :usersData, :settings

    # Load default values for now...
    def awakeFromNib
        # Try to use the same password as last time
        prefs = NSUserDefaults.standardUserDefaults
        hostField.stringValue = prefs.stringForKey("host") || "https://youraccount.talkerapp.com"
        tokenField.stringValue = prefs.stringForKey("token") || "your_api_token"
        
        # Make it so when pressing <return> the login form gets submitted
        hostField.action = "performClick:"
        tokenField.action = "performClick:"
        
        # Hide spinner and error message
        spinner.setHidden true
        errorMsg.setHidden true
    end
    
    def performClick(sender)
        request = ASIHTTPRequest.requestWithURL NSURL.URLWithString("#{hostField.stringValue}/settings.json")
        request.addRequestHeader "X-Talker-Token", value:tokenField.stringValue
        request.setDelegate self
        request.startAsynchronous
        spinner.setHidden false
        spinner.startAnimation 1
        errorMsg.setHidden true
    end

    # On success, parse users in the given room
    def requestFinished(request)
        token = JSON.parse(request.responseString)["talker_token"] rescue false
        
        if token
            # If login was successful, save the settings
            settings.update_settings hostField.stringValue, token:tokenField.stringValue
            
            # Return focus to main window
            app.stopModal
            loginWindow.close
            errorMsg.setHidden true
        else
            errorMsg.setHidden false
        end
        spinner.setHidden true
    end

    # Just explode if something bad happens
    def requestFailed(request)
        spinner.setHidden true
        errorMsg.setHidden false
    end

    # TODO: If I close the modal window, I can't quit the app :/

end