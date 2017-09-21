require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")

DB = PG.connect({:dbname => "to_do_test"})

get("/") do
  @list = List.all()
  erb(:index)
end

post("/") do
  name1 = params.fetch("name1")
  list_object = List.new({:name => name1, :id => nil})
  list_object.save
  @list = List.all()
  erb(:index)
end
# nah-dude
# get("/lists/new") do
#   erb(:list_form)
# end
# nah-dude
# post("/lists") do
#   name = params.fetch("name")
#   list = List.new({:name => name, :id => nil})
#   list.save()
#   erb(:list_success)
# end
# maybe-dude
# get('/lists') do
#   @lists = List.all()
#   erb(:lists)
# end

get("/list/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end
