require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get tenant" do
    get dashboards_tenant_url
    assert_response :success
  end

  test "should get staff" do
    get dashboards_staff_url
    assert_response :success
  end
end
