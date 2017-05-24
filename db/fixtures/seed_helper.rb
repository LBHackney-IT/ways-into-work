class SeedHelper
  include Singleton

  def make_service_managers(user_attrs)
    user_attrs.each do |attrs|
      email = attrs.delete(:email)
      service_manager = ServiceManager.new(attrs)
      service_manager.login = UserLogin.new(email: email, password: 'WaysIntoWork', confirmed_at: Date.today)
      service_manager.save!
    end
  end
end
