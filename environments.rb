configure :development do
  set :database, { adapter: 'sqlite3', database: 'dev.sqlite3' }
  set :show_exceptions, true
end


configure :production do
  db = URI.parse(ENV['DATABASE_URL'])
  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end

configure :test do
  db = URI.parse(ENV['SNAP_DB_PG_URL'] || 'postgres://go:go@localhost/app_test')
  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end