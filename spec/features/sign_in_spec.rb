feature 'User sign in' do

  scenario 'user entering his credentials' do
    sign_up
    sign_in
    expect(page).to have_content "Welcome to your dashboard"
  end



end
