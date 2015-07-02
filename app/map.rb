class Map
  DEFAULT_MESSAGE ='Welcome to our lovely map'
  def initialize


  end

  def get(params)
    @lat = params[:lat]
    @long = params[:long]
    log = Logger.new($stdout)
    log.warn('Initial lat is ')
    log.warn(lat)
    log.warn('Initial long is ')
    log.warn(long)
    show_message
  end

  def post(params)

  end

  def show_message
    Map::DEFAULT_MESSAGE
  end
end
