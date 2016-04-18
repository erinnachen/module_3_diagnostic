class StationService
  def initialize
    @_connection = Faraday.new(url: 'https://developer.nrel.gov/api/alt-fuel-stations/') do |conn|
      conn.request  :url_encoded             # form-encode POST params
      conn.response :logger                  # log requests to STDOUT
      conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      conn.params['format'] = "json"
      conn.params['api_key'] = ENV['nrel_api_key']
    end
  end

  def stations(zipcode)
    response = connection.get do |req|
      req.url '/nearest.json'
      req.params['location'] = zipcode
      req.params['fuel_type'] = "ELEC"
      req.params['limit'] = 10
    end
    binding.pry
  end

  private

    def connection
      @_connection
    end
end
