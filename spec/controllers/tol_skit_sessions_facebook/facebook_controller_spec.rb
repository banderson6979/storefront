RSpec.describe TolSkitSessionsFacebook::FacebookController, type: :controller do
  before(:each) do
    @routes = TolSkitSessionsFacebook::Engine.routes
  end
  
  render_views
  
  let(:json) do
    JSON.parse(response.body)
  end
  
  describe "POST create" do
    it "creates a new facebook user if needed" do
      post "create", user: {uid: "1234",
                     first_name: "John",
                      last_name:  "Doe",
                          email: "john.doe@facebook.com"}
      
      expect(response).to be_success
      expect(User.count).to eq(1)
      
      user = User.first
      expect(user.provider).to eq("facebook")
      expect(user.first_name).to eq("John")
      expect(user.last_name).to eq("Doe")
      expect(user.email).to eq("john.doe@facebook.com")
      expect(user.uid).to eq("1234")
      
    end
  end
end
