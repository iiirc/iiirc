Fabricator(:organization) do
  login       { sequence(:login)        { |i| "iiirc#{i}" } }
  original_id { sequence(:original_id)  { |i| "#{i}"      } }
end
