Fabricator(:star) do
  user    { Fabricate(:user) }
  message { Fabricate(:message) }
  count   { 0 }
end
