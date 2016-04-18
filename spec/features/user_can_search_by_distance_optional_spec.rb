# When I visit "/"
# And I fill in the search form with 80203
# And I enter "5" into an optional "Distance" field
# And I click "Locate"
# Then I should see a list of the 10 closest stations within 5 miles sorted by distance
# And the results should share the same format as above
# And I should see about 6 pagination links at the bottom of the results (As of the writing of this story there are 51 results. Number of links should be RESULTS divided by 10)

require "rails_helper"

RSpec.feature "User can find stations by zip code" do
  scenario "see stations for electrip and propane within 6 miles with info" do
    VCR.use_cassette "search_by_zipcode_distance_5_miles" do
      visit '/'
      fill_in "zip", with: "80203"
      fill_in "distance", with: "5"
      click_on "Locate"

      expect(current_path).to eq "/search"
      within("#station-1") do
        expect(page).to have_content "Name: Cultural Center Complex Garage"
        expect(page).to have_content "Address: 65 W 12th Ave, Denver, CO"
        expect(page).to have_content "Fuel types: ELEC"
        expect(page).to have_content "Distance: 0.41801 miles"
        expect(page).to have_content "Access times: Garage business hours; pay lot"
      end
      within(".pagination") do
        expect(page).to have_content("5")
      end
    end
  end
end
