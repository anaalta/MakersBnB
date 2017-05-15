
feature "User sign in" do

  scenario 'user entering his credentials' do
      sign_in(email: 'email@com', password: '12345')
      expect(page).to have_content "Welcome, email@com"
  end

  def sign_in(email:, password:)
    visit "/sessions/new"
    fill_in :email, with: 'email@com'
    fill_in :password, with: '12345'
    click_on 'Sign in'
  end
  
end
