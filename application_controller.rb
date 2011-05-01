#
# Handles the main chat window
#

require 'json'

class ApplicationController

    attr_accessor :app, :webFrame, :messageForm, :sidebarController, :mainWindow, :loginWindow, :spinner
    attr_accessor :roomsData, :usersData
    attr_accessor :notifier

    # Initialize the app...
    def awakeFromNib
        # Hitting <return> on the message form will post a message
        messageForm.action = "send_message:"
        GrowlApplicationBridge.setGrowlDelegate(self)
    end

    def applicationDidFinishLaunching(n)
        app.runModalForWindow loginWindow
        webFrame.mainFrame.loadHTMLString "<p style='font-family: Verdana;'>Loading...</p>", baseURL:nil
        webFrame.setHidden true
        mainWindow.display
        mainWindow.orderFrontRegardless
        spinner.startAnimation(0)
        roomsData.fetch
    end

    # Called when the web frame is done loading
    def webView(view, didFinishLoadForFrame:frame)
        # Set up the room
        adaptRoomStyle
        loadNotifier

        # Make the web frame visible
        spinner.stopAnimation(0)
        webFrame.setHidden false
    end

    # Hide unneeded HTML elements in the Talker room
    def adaptRoomStyle
        webFrame.windowScriptObject.evaluateWebScript(
            "$('#sidebar, #message_form').hide();"+
            "$('body').css({ background: 'white' });"+
            "$('#chat_log').css({ '-webkit-box-shadow': 'none', margin: '0 10px 0 0' });"+
            "$('#main').css({ margin: '0px 25px 0 15px', padding: '0 10px' });")
    end
    
    # Load the Cocoa-JS notifier bridge to notify about new messages
    def loadNotifier
        # Initialize the Notifier object in Javascript
        #notifier = Notifier.new
        js = webFrame.windowScriptObject
        js.setValue(notifier, forKey: "Notifier")
        
        # Make the method accessible from JS. We use the colon because it takes arguments
        notifier.respondsToSelector("received:")

        webFrame.windowScriptObject.evaluateWebScript(
            "if (!window.loadedGrowlNotify) {"+
            "   window.loadedGrowlNotify = true;"+
            "   Talker.plugins.push( new function() { this.onMessageReceived = function(msg) {"+
            "       Notifier.received_(msg.user.name+': '+msg.content);"+
            "   } });"+
            "};")
    end
    
    # Post a message to the room using JS in the room itself
    def send_message(n)
        if messageForm.stringValue && messageForm.stringValue.length > 0
            webFrame.windowScriptObject.evaluateWebScript(
                "Talker.trigger('MessageSend', {type:'message', content: #{messageForm.stringValue.to_json}})")
            messageForm.stringValue = ""
        end
    end

    # Close the application if there are no open windows
    def applicationShouldTerminateAfterLastWindowClosed(sender)
        true
    end

end
