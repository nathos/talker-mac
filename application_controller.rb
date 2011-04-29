require 'json'

class ApplicationController

  # Main web view
  attr_accessor :webView

  # Form to send messages
  attr_accessor :messageForm

  # Controller for the sidebar
  attr_accessor :sidebarController

  # Initialize the app...
  def awakeFromNib
	webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"

	# Hitting <return> on the message form will post a message
	messageForm.action = "send_message:"

	GrowlApplicationBridge.setGrowlDelegate(self)
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
