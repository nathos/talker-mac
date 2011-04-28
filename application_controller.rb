require 'json'

class ApplicationController
  # Main web view and sidebar
  attr_accessor :webView
  attr_accessor :sidebarView

  # Fields for the sidebar
  attr_accessor :first_name
  
  # Form to send messages
  attr_accessor :messageForm

  # Initialize the app...
  def awakeFromNib

	webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"

	# Selecting an element on the sidebar
	sidebarView.action = "edit:"

	# Hitting <return> on the message form will post a message
	messageForm.action = "send_message:"

	# Load the data for the sidebar
	populate_sidebar
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

  def edit(sender)
	puts "click"
	case sidebarView.selectedRow
	when 0
	  webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"
	when 1
	  webView.mainFrameURL = "https://teambox.talkerapp.com/rooms/819"
	end
  end

  def populate_sidebar
    @names = ["Local installation", "Remote Talker"]
    sidebarView.dataSource = self
  end

  def numberOfRowsInTableView(view)
    @names.size
  end

  def tableView(view, objectValueForTableColumn:column, row:index)
	@names[index]
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
