class SeedHelper
  include Singleton

  def make_advisors(user_attrs)
    user_attrs.each do |attrs|
      email = attrs.delete(:email)
      if login = UserLogin.find_by(email: email)
        login.user.update_attributes(attrs)
      else
        advisor = Advisor.new(attrs)
        advisor.login = UserLogin.new(email: email, password: ENV['DEFAULT_PASSWORD'])
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
    number.times.each do |_n|
      advisor = Advisor.all.sample
      Fabricate(%i[client partial_reg_client fully_reg_client].sample, advisor: advisor)
    end
  end
end
