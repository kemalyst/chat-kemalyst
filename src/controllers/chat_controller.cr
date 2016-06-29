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
      socket.on_message do |message|
        @messages.push message
        @sockets.each do |a_socket|
          a_socket.send @messages.to_json
        end
      end
    end
  end
end


