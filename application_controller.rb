#
# Handles the main chat window
#

require 'json'

class ApplicationController

    attr_accessor :app, :webView, :messageForm, :sidebarController, :loginWindow
    attr_accessor :roomsData, :usersData

    # Initialize the app...
    def awakeFromNib
        # Hitting <return> on the message form will post a message
        messageForm.action = "send_message:"

        GrowlApplicationBridge.setGrowlDelegate(self)
    end

    def applicationDidFinishLaunching(n)
        # TODO: Ask for credentials the first time
        #app.runModalForWindow loginWindow
        roomsData.fetch
    end
    
    # Post a message to the room using JS in the room itself
    def send_message(n)
        if messageForm.stringValue && messageForm.stringValue.length > 0
            puts messageForm.stringValue
            webView.windowScriptObject.evaluateWebScript("Talker.sendMessage(#{messageForm.stringValue.to_json})")
            messageForm.stringValue = ""
        end
    end

    # Displays Growl notifications for events
    def growl(message)
        GrowlApplicationBridge.notifyWithTitle("Talker",
            description: message,
            notificationName: "Test",
            iconData: nil,
            priority: 0,
            isSticky: false,
            clickContext: nil)
    end

end
