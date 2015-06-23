module RandomIncidents
  class SendFakeIncidentSms
    TWILIO_SID    = ENV.fetch('twilio_account_sid').freeze
    TWILIO_TOKEN  = ENV.fetch('twilio_auth_token').freeze
    FROM_NUMBER   = ENV.fetch('sms_from_number').freeze
    TO_NUMBER     = ENV.fetch('sms_to_number').freeze
    SMS_BODY      = "It's time to break some stuff".freeze

    def send_sms
      client.account.messages.create from: FROM_NUMBER, to: TO_NUMBER, body: SMS_BODY
    end

    alias_method :call, :send_sms

    private

    def client
      Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    end
  end
end
