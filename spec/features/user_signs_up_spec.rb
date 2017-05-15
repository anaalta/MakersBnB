feature 'User signs up' do
  scenario 'user creates an account' do
    sign_up
    expect(current_path).to eq ('/home')
    expect { sign_up }.to change(User, :count).by(1)
  end
end
