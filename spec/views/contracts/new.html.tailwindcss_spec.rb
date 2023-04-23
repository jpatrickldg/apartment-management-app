require 'rails_helper'

RSpec.describe "contracts/new", type: :view do
  before(:each) do
    assign(:contract, Contract.new(
      tenant_name: "MyString",
      tenant_address: "MyText",
      room_code: "MyString",
      monthly_rate: "9.99",
      status: 1,
      booking: nil
    ))
  end

  it "renders new contract form" do
    render

    assert_select "form[action=?][method=?]", contracts_path, "post" do

      assert_select "input[name=?]", "contract[tenant_name]"

      assert_select "textarea[name=?]", "contract[tenant_address]"

      assert_select "input[name=?]", "contract[room_code]"

      assert_select "input[name=?]", "contract[monthly_rate]"

      assert_select "input[name=?]", "contract[status]"

      assert_select "input[name=?]", "contract[booking_id]"
    end
  end
end
