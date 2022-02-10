json.call(server, :name, :updating)
json.id server.id.to_s
json.manager current_user.manage?(server)
