json.channels @channels do |channel|
  json.partial! channel
end

json.flash flash.to_h unless flash.empty?
