class ApplicationController
  attr_accessor :webView
  attr_accessor :sidebarView

  # fields
  attr_accessor :first_name
  
  attr_accessor :messageForm

  def awakeFromNib
	webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"
	sidebarView.action = "edit:"
	puts messageForm.inspect
	messageForm.action = "send_message:"
	populate_sidebar
  end

  def send_message(sender)
	if messageForm.stringValue
  	  @js = webView.windowScriptObject
	  @js.evaluateWebScript("Talker.sendMessage('"+messageForm.stringValue+"')")
	  messageForm.stringValue = ""
	end
  end

  def edit(sender)
	puts "click"
  end

  def populate_sidebar
    @names = ["My rooms", "Barcelona", "Hong Kong"]
    sidebarView.dataSource = self
  end

  def numberOfRowsInTableView(view)
    @names.size
  end

  def tableView(view, objectValueForTableColumn:column, row:index)
	@names[index]
  end

end
