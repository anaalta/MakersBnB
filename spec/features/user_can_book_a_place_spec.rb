feature 'Users can book spaces' do
  scenario 'a user books a listed place' do
    sign_up
    sign_in
    click_link listing.property_name
    expect(page).to have_content :property_name
    click_button 'Book this property'
    fill_in :start_date, with: '21/08/2017'
    fill_in :end_date, with: '24/08/2017'
    click_button 'Confirm booking'
    expect(page).to have_content ('Thank you for your booking!')
  end
end
