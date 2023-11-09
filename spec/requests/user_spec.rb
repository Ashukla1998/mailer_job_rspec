# require 'rails_helper'

# RSpec.describe UsersController, type: :request do
#     before(:each) do
#         @user = User.create(name: "ashu",email: "testing@yopmail.com")
#     end
#     describe '#create and login' do
#     let(:base_url) {"/users"}
#     let(:create_params) {
#       {user: {name: "ashu",email: "test12@gmail.com"}}
#     }
#     context "Create User" do
#         it 'return a user for show user api' do
#             pre_user_count = User.count
#             post base_url, params: create_params
#             expect(response).to have_http_status(200)
#             res = JSON response.body
#             expect(User.count).to eq(pre_user_count+1)
            
#         end
#         it 'raise error when pass wrong arguments' do
#             post base_url, params: {user: {name: "",email: "", mob:nil}}
#             expect(response).to have_http_status(422)
#         end
#     end
#     end
# end

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before(:each) do
    @user = User.create(name: "ashu", email: "testing@yopmail.com")
  end

  describe '#create and login' do
    let(:base_url) {"/users"}
    let(:create_params) {
      { user: { name: "ashu", email: "test12@gmail.com" } }
    }

    context "Create User" do
      it 'returns a user for show user api' do
        pre_user_count = User.count
        post base_url, params: create_params
        expect(response).to have_http_status(200)
        res = JSON.parse(response.body)
        expect(User.count).to eq(pre_user_count + 1)
      end

      it 'raises error when pass wrong arguments' do
        # debug/ger
        post base_url, params: { user: { name: "", email: ""} }
        expect(response).to have_http_status(422)
      end

      it 'enqueues SendWelcomeEmailJob when user is created' do
        expect {
          post base_url, params: create_params
        }.to have_enqueued_job(SendWelcomeEmailJob).on_queue('default')
      end
    end
  end
end
