require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      :number => "MyString",
      :balance => "9.99",
      :password => "MyString"
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input[name=?]", "account[number]"

      assert_select "input[name=?]", "account[balance]"

      assert_select "input[name=?]", "account[password]"
    end
  end
end
