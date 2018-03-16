class ContactMethodOption < Option
  def self.all
    [
      new('email', 'Email'),
      new('phone', 'Phone call'),
      new('sms_reminder', 'Text reminders')
    ]
  end
end
