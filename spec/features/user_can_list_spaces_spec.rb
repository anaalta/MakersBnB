feature 'User can list spaces' do

  scenario 'a signed in user can list a space with all details' do
  sign_up
  click_button 'Add your space here!'
  expect(current_path).to eq ('/spaces/new')
  fill_in :property_name, with: 'my property'
  fill_in :description, with: 'nice cosy place'
  fill_in :price_per_night, with: '35'
  click_button 'Submit'
  save_and_open_page
  expect(page).to have_content ("Thank you for adding your space")
  expect(page).to have_content (:property_name)
  expect(page).to have_content (:description)
  expect(page).to have_content (:price_per_night)
  end

end
