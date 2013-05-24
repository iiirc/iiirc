class SnippetDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :messages
end
