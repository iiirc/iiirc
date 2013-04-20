Fabricator(:star) do
  user    { Fabricate(:user) }
  message { Fabricate(:message) }
  count   { 1 }
end
