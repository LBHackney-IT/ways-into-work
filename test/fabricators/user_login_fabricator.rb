Fabricator(:user_login) do
  email { "#{FFaker::Internet.user_name}@example.com" }
  password 'Freddy321'
end
