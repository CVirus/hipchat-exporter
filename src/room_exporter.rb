require 'hipchat'

class RoomExporter
  MAX_RESULTS = 1000

  attr_reader :client

  def initialize
    @client = HipChat::Client.new(ENV['HIPCHAT_TOKEN'], :server_url => 'http://hipchat.zalando.net')
  end

  def perform
    offset = 0

    loop do
      rooms = fetch(offset: offset)

      rooms.each do |room|
        save(room)
      end

      if rooms.size == RoomExporter::MAX_RESULTS
        offset += RoomExporter::MAX_RESULTS
      else
        break
      end
    end
  end

  private

  def fetch(offset: 0)
    # https://www.hipchat.com/docs/apiv2/method/get_all_rooms
    client.rooms(
      :'start-index' => offset,
      :'max-results' => RoomExporter::MAX_RESULTS,
      :'include-private' => true,
      :'include-archived' => true,
    )
  end

  def save(room)
    Room.find_or_create_by(id: room.id) do |r|
      r.name = room.name
      r.privacy = room.privacy
      r.archived = room.is_archived
    end
  end
end
