
class Settings

    attr_accessor :host, :token

    def initialize
        prefs = NSUserDefaults.standardUserDefaults
        @host = prefs.stringForKey("host")
        @token = prefs.stringForKey("token")
        puts "fetched settings: #{@host} #{@token}"
    end

    # Are settings defined?
    def present?
        !!(@host and @token)
    end

    # Save settings to preferences
    def update_settings(host, token:token)
        prefs = NSUserDefaults.standardUserDefaults
        prefs.setObject host, forKey:"host"
        prefs.setObject token, forKey:"token"
    end

end