# coding: utf-8
#
# rake misc:parse_messages
# this script doesn't have a side effect. take it easy :)
#
# snippet_id - string
#              Snippet.id (required)
#
# Examples
#
#   $ RAILS_ENV=production bundle exec rake misc:parse_messages snippet_id=97
#
# Returns Nothing.

namespace :misc do
  desc "re-parse messages for specify snippet"
  task parse_messages: :environment do

    unless snippet_id = ENV['snippet_id']
      $stderr.puts "You have to pass snippet id"
      exit
    end

    snippet = Snippet.find snippet_id
    snippet.messages.each { |message| message.parse_content; message.save }
  end
end
