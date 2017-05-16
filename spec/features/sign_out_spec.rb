feature 'User sign out' do

  scenario 'user can sign out from their account' do
    sign_up
    click_button 'Sign Out'
    expect(current_path).to eq '/'
    expect(page).not_to have_content 'Welcome to your dashboard'
  end
end
