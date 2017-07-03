class SeedHelper
  include Singleton

  def make_service_managers(user_attrs)
    user_attrs.each do |attrs|
      email = attrs.delete(:email)
      if login = UserLogin.find_by_email(email)
        login.user.update_attributes(attrs)
      else
        service_manager = ServiceManager.new(attrs)
        service_manager.login = UserLogin.new(email: email, password: 'WaysIntoWork')
        service_manager.save!
      end
    end
  end

  def make_advisors(user_attrs)
    user_attrs.each do |attrs|
      email = attrs.delete(:email)
      if login = UserLogin.find_by_email(email)
        login.user.update_attributes(attrs)
      else
        advisor = Advisor.new(attrs)
        advisor.login = UserLogin.new(email: email, password: 'WaysIntoWork')
        advisor.save!
      end
    end
  end

  def make_hubs(hub_attrs)
    hub_attrs.each do |attrs|
      hub = Hub.where(id: attrs.delete(:id)).first_or_initialize
      hub.update_attributes(attrs)
    end
  end

  def make_clients(number)
    number.times.each do |n|
      advisor = Advisor.all.sample
      Fabricate(:client, advisor: advisor )
    end
  end
end
