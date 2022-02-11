json.ranks @ranks do |rank|
  json.partial! rank
end

json.flash flash.to_h
