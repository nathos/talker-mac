#
# This class is a JS-Cocoa bridge. It is made available for the controller
# so the Notifier.received_('some message') method can be called from JS
#

class Notifier

    attr_accessor :app, :enabled

    # Listen for the application becoming active to clear notifications
    def awakeFromNib
        NSNotificationCenter.defaultCenter.addObserver self,
            selector:"clearNotifications:",
            name:"NSApplicationDidBecomeActiveNotification",
            object:nil
    end
    
    # Clear the notifications badge
    def clearNotifications(n)
        @unread_count = 0
        app.dockTile.setBadgeLabel ""
    end

    # If the app isn't active, display a Growl notification and increase the dock badge
    def received(message)
        return if app.isActive

        @unread_count ||= 0
        @unread_count += 1
        app.dockTile.setBadgeLabel @unread_count.to_s
        
        GrowlApplicationBridge.notifyWithTitle("Talker",
            description: message,
            notificationName: "Test",
            iconData: nil,
            priority: 0,
            isSticky: false,
            clickContext: nil)
    end

    # Make all the methods available from JS
    def self.isSelectorExcludedFromWebScript(sel); false; end

end
