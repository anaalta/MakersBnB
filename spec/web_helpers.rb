def sign_up
  visit '/users/new'
  fill_in :email, with: 'test@example.com'
  fill_in :first_name, with: 'first_name'
  fill_in :last_name, with: 'last_name'
  fill_in :password, with: '12345'
  click_button 'Sign Up'
end

def sign_in
  visit '/sessions/new'
  fill_in :email, with: 'test@example.com'
  fill_in :password, with: '12345'
  click_on 'Sign in'
end
