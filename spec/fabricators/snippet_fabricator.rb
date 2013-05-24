Fabricator(:snippet) do
  user
  organization
  title        { sequence(:title) {|i| "title#{i}" } }
  published    { true }
end
