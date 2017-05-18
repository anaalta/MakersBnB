feature 'Users can book spaces' do
  scenario 'a user books a listed place' do
    sign_up
    sign_in
    save_and_open_page
    within"ol#listings" do
      click_button "Book Me"
      find('#id_of_element').click
    end
    expect(page).to have_content :property_name
    click_button 'Book this property'
    fill_in :start_date, with: '21/08/2017'
    fill_in :end_date, with: '24/08/2017'
    click_button 'Confirm booking'
    expect(page).to have_content ('Thank you for your booking!')
  end
end
