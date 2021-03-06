def sign_up
  visit '/users/new'
  fill_in :email, with: 'test@example.com'
  fill_in :first_name, with: 'first_name'
  fill_in :last_name, with: 'last_name'
  fill_in :password, with: '12345'
  fill_in :password_confirmation, with: '12345'
  click_button 'Sign Up'
end

def sign_up2
  visit '/users/new'
  fill_in :email, with: 'test2@example.com'
  fill_in :first_name, with: 'first_name2'
  fill_in :last_name, with: 'last_name2'
  fill_in :password, with: '123452'
  fill_in :password_confirmation, with: '123452'
  click_button 'Sign Up'
end


def sign_in
  visit '/sessions/new'
  fill_in :email, with: 'test@example.com'
  fill_in :password, with: '12345'
  click_on 'Sign in'
end

def sign_in2
  visit '/sessions/new'
  fill_in :email, with: 'test2@example.com'
  fill_in :password, with: '123452'
  click_on 'Sign in'
end


def wrong_sign_up
  visit '/users/new'
  fill_in :email, with: 'test@example.com'
  fill_in :first_name, with: 'first_name'
  fill_in :last_name, with: 'last_name'
  fill_in :password, with: '12345'
  fill_in :password_confirmation, with: 'wrong'
end

def add_property
  sign_up
  sign_in
  click_on 'Add your space here!'
  fill_in :property_name, with: 'my property'
  fill_in :description, with: 'nice cosy place'
  fill_in :price_per_night, with: '35'
  fill_in :available_from, with: '25/05/2017'
  fill_in :available_until, with: '22/06/2017'
  click_button 'Submit'
end
