feature 'Users can book spaces' do
  scenario 'a user books a listed place' do
    sign_up
    sign_in
    click_on 'Add your space here!'
    fill_in :property_name, with: 'my property'
    fill_in :description, with: 'nice cosy place'
    fill_in :price_per_night, with: '35'
    fill_in :available_from, with: '25/05/2017'
    fill_in :available_until, with: '22/06/2017'
    click_button 'Submit'
    expect(current_path).to eq ('/dashboard')
    within"ol#listings" do
      click_button "Book Me"
    end
    expect(page).to have_content :property_name
    fill_in :start_date, with: '21/08/2017'
    fill_in :end_date, with: '24/08/2017'
    click_button 'Confirm booking'
    expect(page).to have_content ('Thank you for your booking!')
  end
end
