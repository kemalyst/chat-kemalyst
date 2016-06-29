require "../src/controllers/*"
include Kemalyst::Handler

get "/", [ChatController::Chat.instance,
          ChatController::Index.instance]
