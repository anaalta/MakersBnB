feature 'User signs up' do

  scenario 'user creates an account' do
    sign_up
    #expect(current_path).to eq ('/')
    expect(User.last.email).to eq('ana@example.com')
    expect { sign_up }.to change(User, :count).by(1)
  end
end
