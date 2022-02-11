json.servers @servers do |server|
  json.partial! server
end

json.flash flash.to_h unless flash.empty?
