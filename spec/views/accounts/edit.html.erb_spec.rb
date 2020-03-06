require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :number => "MyString",
      :balance => "9.99",
      :password => "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input[name=?]", "account[number]"

      assert_select "input[name=?]", "account[balance]"

      assert_select "input[name=?]", "account[password]"
    end
  end
end
