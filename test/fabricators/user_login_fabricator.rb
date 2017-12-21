Fabricator(:user_login) do
  email { "#{FFaker::Internet.unique.user_name}@example.com" }
  password { ENV['DEFAULT_PASSWORD'] }
end
