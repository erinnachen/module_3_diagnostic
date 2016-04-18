class Station

  def self.find(zipcode)
    stations = service.stations(zipcode)
  end

  private
    def self.service
      StationService.new
    end
end
