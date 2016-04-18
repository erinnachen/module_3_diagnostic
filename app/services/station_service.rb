class StationService

  def initialize
    @_connection = Faraday.new(url: 'https://developer.nrel.gov') do |conn|
      conn.request  :url_encoded             # form-encode POST params
      conn.response :logger                  # log requests to STDOUT
      conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      conn.params['format'] = "json"
      conn.params['api_key'] = ENV['nrel_api_key']
    end
  end

  def stations(zipcode)
    response = connection.get do |req|
      req.url '/api/alt-fuel-stations/v1/nearest.json'
      req.params['location'] = zipcode
      req.params['fuel_type'] = "ELEC,LPG"
      req.params['limit'] = 10
    end
    parse_response(response)[:fuel_stations]
  end

  private

    def connection
      @_connection
    end

    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
