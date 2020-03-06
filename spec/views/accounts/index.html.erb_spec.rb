require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :number => "Number",
        :balance => "9.99",
        :password => "Password"
      ),
      Account.create!(
        :number => "Number",
        :balance => "9.99",
        :password => "Password"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
