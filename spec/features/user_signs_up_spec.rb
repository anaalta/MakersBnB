feature 'User signs up' do

  scenario 'user creates an account' do
    sign_up
    #expect(current_path).to eq ('/')
    expect(User.last.email).to eq('test@example.com')
    expect { sign_up }.to change(User, :count).by(1)
  end

   scenario 'I cannot sign up without an email address' do
     visit '/users/new'
     fill_in :email, with: nil
     fill_in :first_name, with: 'first_name'
     fill_in :last_name, with: 'last_name'
     fill_in :password, with: '12345'
     fill_in :password_confirmation, with: '12345'
     click_button 'Sign Up'
    expect(current_path).to eq('/users/new')
#    expect(page).to have_content('Email must not be blank')
  end

  scenario 'I cannot sign up with an invalid email address' do
    visit '/users/new'
    fill_in :email, with: 'invalid@email'
    fill_in :first_name, with: 'first_name'
    fill_in :last_name, with: 'last_name'
    fill_in :password, with: '12345'
    fill_in :password_confirmation, with: '12345'
    click_button 'Sign Up'
   expect(current_path).to eq('/users/new')
#   expect(page).to have_content('Email has an invalid format')
 end

   scenario 'it doesn\'t sign up if passwords do not match' do
     wrong_sign_up
     expect(current_path).to eq('/users/new')
#     expect(page).to have_content 'Passwords do not match'
   end
end
