class Application 
  @@items = []
  def call(env)

    req = Rack::Request.new(env)
    resp = Rack::Response.new

    item_name = req.path.match(/items/) {item_name = req.path.match(/\w*\Z/)[0]}

    if item_name
      itm = @@items.find{|item| item.name == item_name}
      if itm
        resp.write itm.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end

