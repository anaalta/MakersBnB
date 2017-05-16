feature 'User can list spaces' do
  scenario 'a signed in user can list a space' do
  sign_up
  click_button 'Add your space here!'
  expect(current_path).to eq ('/spaces/new')
  fill_in :property, with: 'my property'
  click_button 'Submit'
  expect(page).to have_content ('Thank you for adding your space')
  end
end
