RSpec.shared_context 'skip welcome email' do
  before(:each) do
    User.skip_callback(:create, :after, :send_welcome_email)
  end

  after(:each) do
    User.set_callback(:create, :after, :send_welcome_email)
  end
end
