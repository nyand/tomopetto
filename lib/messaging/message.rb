class Message

    attr_reader :sender, :payload
    def initialize(sender, payload = {})
     @sender = sender
     @payload = payload
    end

end
