class Station
  attr_reader :name, :access_times, :distance, :fuel_types, :city, :state, :street_address
  def initialize(data)
    @name = data[:station_name]
    @street_address = data[:street_address]
    @city = data[:city]
    @state = data[:state]
    @distance = data[:distance]
    @fuel_types = data[:fuel_type_code]
    @access_times = data[:access_days_time]
  end

  def address
    "#{street_address}, #{city}, #{state}"
  end

  def self.find(zipcode)
    data = service.stations(zipcode)
    data.map { |station_data|
      Station.new(station_data)
    }
  end

  private

    def self.service
      StationService.new
    end
end
