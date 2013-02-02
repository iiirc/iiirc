class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :messages, dependent: :destroy

  attr_accessible :published, :title, :organization_id

  attr_writer :content

  def save
    self.class.transaction do
      return unless super
      if @content
        messages = @content.each_line.collect {|raw_content|
          Message.new(raw_content: raw_content.chomp)
        }
        self.messages = messages.select {|message| message.content.present?}
      else
        true
      end
    end
  end
end
