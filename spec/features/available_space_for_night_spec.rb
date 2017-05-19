feature "#Space for the night" do
    scenario "selects available space for the night" do
      bookings
      expect(current_path).to eq "/booking/new"
      expect(page).to have_content('Available dates:')
    end
end
