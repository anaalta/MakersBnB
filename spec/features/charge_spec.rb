feature '#Charge booking' do
  scenario "it charges the user when congirming a booking" do
    bookings
    fill_in :start_date, with: '01/01/2017'
    fill_in :end_date, with: '10/01/2017'
    click_on 'Confirm booking'
    expect(page).to have_content('Please made a payment to finalise your booking')
  end
end
