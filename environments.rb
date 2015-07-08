configure :development do
		set :database, {adapter: "sqlite3", database: "dev.sqlite3"}
 	set :show_exceptions, true
end

# configure :test do
#  db = URI.parse('postgres://mydb')

#  ActiveRecord::Base.establish_connection(
#  		:adapter => "postgresql",
#  		:encoding => "utf8",
#  		:database => "mydb",
#  		:pool => 5,
#  		:username => "stewarts",
#  		:password => "",
#  		:host => "localhost"
#    # :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#    # :host     => db.host,
#    # :username => db.user,
#    # :password => db.password,
#    # :database => db.path[1..-1],
#    # :encoding => 'utf8'
#  )
#  puts 
# end

configure :production do
 db = URI.parse(ENV['DATABASE_URL']	|| 'postgres:///localhost/mydb')
 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end
