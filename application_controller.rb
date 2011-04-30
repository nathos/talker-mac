require 'json'

class ApplicationController

    attr_accessor :app, :webView, :messageForm, :sidebarController, :loginWindow

    # Initialize the app...
    def awakeFromNib
        webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"
        webView.mainFrameURL = "http://teambox.talkerapp.com/rooms/819"

        # Hitting <return> on the message form will post a message
        messageForm.action = "send_message:"

        GrowlApplicationBridge.setGrowlDelegate(self)
    end

    def applicationDidFinishLaunching(n)
        #app.runModalForWindow loginWindow
        
        url = NSURL.URLWithString "https://teambox.talkerapp.com/rooms.json"
        request = ASIHTTPRequest.requestWithURL url
        request.addRequestHeader "X-Talker-Token", value:"ea275113713187301a1f520c5772658f4cf617c6"
        
        request.startSynchronous
        error = request.error
        if !error
            response = request.responseString
            puts JSON.parse(response).inspect
        end
    end
    
    def didReceiveResponse(response)
        puts "got it!!!!"
    end
    
    def didReceiveData(data)
        puts "got it!!!!"
    end    
    
    # Post a message to the room using JS in the room itself
    def send_message(sender)
        if messageForm.stringValue && messageForm.stringValue.length > 0
            puts messageForm.stringValue
            @js = webView.windowScriptObject
            @js.evaluateWebScript("Talker.sendMessage(#{messageForm.stringValue.to_json})")
            messageForm.stringValue = ""
        end
    end

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
