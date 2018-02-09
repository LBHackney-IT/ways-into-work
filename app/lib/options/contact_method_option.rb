class ContactMethodOption < Option
  def self.all
    [
      new('email', 'Email'),
      new('phone', 'Phone call'),
      new('sms_reminder', 'SMS reminders (for meetings)')
    ]
  end
end
