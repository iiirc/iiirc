Fabricator(:user) do
  username { sequence(:username) { |i| "alice#{i}" } }
  email    { sequence(:email)    { |i| "alice_#{i}@example.org" } }
  provider "github"
  uid      { sequence(:uid)      { |i| "foobar#{i}" } }
end
