feature 'select dates when property is available' do

  scenario 'user selects available interval' do
    sign_up
    sign_in
    click_button 'Add your space here!'
    expect(current_path).to eq ('/spaces/new')
    fill_in :property_name, with: 'my property'
    fill_in :description, with: 'nice cosy place'
    fill_in :price_per_night, with: '35'
    fill_in :available_from, with: '25/05/2017'
    fill_in :available_until, with: '22/06/2017'
    click_button 'Submit'
    expect(current_path).to eq ('/dashboard')
    expect(page).to have_content :property_name 
    expect(page).to have_content :description 
    expect(page).to have_content :price_per_night
    expect(page).to have_content :available_from 
    expect(page).to have_content :available_until
  end
end
