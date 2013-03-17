Fabricator(:snippet) do
  user         { Fabricate(:user) }
  organization { Fabricate(:organization) }
  title        { sequence(:title) {|i| "title#{i}" } }
  published    { true }
end
