json.channels @channels do |channel|
  json.partial! channel
  channel.children do |child|
    json.child! child
  end
end
