#
# This class is a JS-Cocoa bridge. It is made available for the controller
# so the Notifier.received_('some message') method can be called from JS
#

class Notifier

    attr_accessor :app, :enabled

    def received(message)
        return if app.isActive
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
