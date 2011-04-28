require 'rack_url_protocol'

class ApplicationController
  attr_accessor :webView
  attr_accessor :sidebarView

  # fields
  attr_accessor :first_name

  def awakeFromNib
	webView.mainFrameURL = "http://asdasdasda.lvh.me:3000/rooms/1059638631"
	sidebarView.action = "edit:"
	retrieve_names
  end

  def edit(sender)
	puts "click"
  end

  def retrieve_names
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
