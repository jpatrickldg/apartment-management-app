require 'rails_helper'

RSpec.describe "contracts/index", type: :view do
  before(:each) do
    assign(:contracts, [
      Contract.create!(
        tenant_name: "Tenant Name",
        tenant_address: "MyText",
        room_code: "Room Code",
        monthly_rate: "9.99",
        status: 2,
        booking: nil
      ),
      Contract.create!(
        tenant_name: "Tenant Name",
        tenant_address: "MyText",
        room_code: "Room Code",
        monthly_rate: "9.99",
        status: 2,
        booking: nil
      )
    ])
  end

  it "renders a list of contracts" do
    render
    assert_select "tr>td", text: "Tenant Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Room Code".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
