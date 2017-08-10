Fabricator(:user_login) do
  email { "#{FFaker::Internet.user_name}@example.com" }
  password { ENV['DEFAULT_PASSWORD'] }
end
