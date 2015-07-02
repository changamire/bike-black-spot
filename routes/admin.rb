get '/' do
  Root.new.get(params)
end
