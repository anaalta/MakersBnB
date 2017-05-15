def sign_up
visit '/'
fill_in :email, with: 'ana@example.com'
fill_in :first_name, with: 'Ana'
fill_in :last_name, with: 'Suciu'
fill_in :password, with: 'password'
click_button 'Sign Up'
end
