class Snippet < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy

  attr_accessible :published, :title

  attr_writer :content

  def save
    self.class.transaction do
      return unless super
      if @content
        messages = @content.each_line.collect {|raw_message|
          Message.new(raw_content: raw_message.chomp)
        }
        self.messages = messages
      else
        true
      end
    end
  end
end
