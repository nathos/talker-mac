
class SidebarController

  attr_accessor :webView, :sidebarView, :first_name
  
  # Initialize the app...
  def awakeFromNib
	populate_sidebar
  end

  def tableViewSelectionDidChange(notification)
	puts "clicked #{sidebarView.selectedRow}"

	webView.mainFrameURL = case sidebarView.selectedRow
	when 0 then "http://asdasdasda.lvh.me:3000/rooms/1059638631"
	when 1 then "https://teambox.talkerapp.com/rooms/819"
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

end
