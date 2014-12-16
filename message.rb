class Message

    attr_reader :sender, :payload
    def initialze(sender, payload = {})
     @sender = sender
     @payload = payload
    end

end
