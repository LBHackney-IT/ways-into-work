Fabricator(:user_login) do
  email { FFaker::Internet.email }
  password 'Freddy321'
  confirmed_at Time.now
end
