require "./spec_helper"

describe ChatController::Index do

  it "renders chat/index.ecr" do
    request = HTTP::Request.new("GET", "/")
    io, context = create_context(request)
    response = ChatController::Index.instance.call(context) as String
    response.should contain "React Example with Kemalyst"
  end

  it "upgrades to a websocket" do
    headers = HTTP::Headers {
      "Upgrade" => "websocket",
      "Connection" => "Upgrade",
      "Sec-WebSocket-Key" => "dGhlIHNhbXBsZSBub25jZQ=="
    }
    request = HTTP::Request.new("GET", "/", headers)
    io, context = create_context(request)
    response = ChatController::Chat.instance.call(context)
    context.response.status_code.should eq 101
  end
end
