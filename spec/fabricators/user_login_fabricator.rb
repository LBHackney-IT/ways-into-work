Fabricator(:user_login) do
  email { FFaker::Internet.email }
  password 'Freddy321'
end
