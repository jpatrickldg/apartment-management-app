require 'rails_helper'

RSpec.describe "contracts/show", type: :view do
  before(:each) do
    @contract = assign(:contract, Contract.create!(
      tenant_name: "Tenant Name",
      tenant_address: "MyText",
      room_code: "Room Code",
      monthly_rate: "9.99",
      status: 2,
      booking: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tenant Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Room Code/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
