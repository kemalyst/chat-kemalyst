include Kemalyst

module ChatController
  class Index < Kemalyst::Controller
    def call(context)
      render "chat/index.ecr"
    end
  end

  class Chat < Kemalyst::WebSocket
    @sockets = [] of HTTP::WebSocket
    @messages = [] of String

    def call(socket : HTTP::WebSocket)
      @sockets.push socket

      # Handle incoming message and dispatch it to all connected clients
      socket.on_message do |message|
        @messages.push message
        @sockets.each do |a_socket|
          begin
            a_socket.send @messages.to_json
          rescue ex
            @sockets.delete a_socket
            puts "An error has happened: #{ex.message}"
          end
        end
      end

      # Handle disconnection and clean sockets
      socket.on_close do |_|
        @sockets.delete socket
        puts "Closing Socket: #{socket}"
      end
    end
  end
end
