# As a user
# When I visit "/"
# And I fill in the search form with 80203
# And I click "Locate"
# Then I should be on page "/search?zip=80203"
# Then I should see a list of the 10 closest stations within 6 miles sorted by distance
# And the stations should be limited to Electric and Propane
# And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times

require "rails_helper"

RSpec.feature "User can find stations by zip code" do
  scenario "see stations for electrip and propane within 6 miles with info" do
    VCR.use_cassette "search_by_zipcode" do
      visit '/'
      fill_in "q", with: "80203"
      click_on "Locate"

      #expect(current_path).to eq "/search?zip=80203"
      within("#station-1") do
        expect(page).to have_content "New name"
        expect(page).to have_content "address"
        expect(page).to have_content "ELectric"
        expect(page).to have_content "1.5 miles"
        expect(page).to have_content "Accessible within: 6am-10pm"
      end
    end
  end
end
