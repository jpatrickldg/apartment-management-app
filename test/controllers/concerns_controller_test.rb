require "test_helper"

class ConcernsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get concerns_index_url
    assert_response :success
  end

  test "should get show" do
    get concerns_show_url
    assert_response :success
  end

  test "should get new" do
    get concerns_new_url
    assert_response :success
  end

  test "should get create" do
    get concerns_create_url
    assert_response :success
  end

  test "should get edit" do
    get concerns_edit_url
    assert_response :success
  end

  test "should get update" do
    get concerns_update_url
    assert_response :success
  end

  test "should get destroy" do
    get concerns_destroy_url
    assert_response :success
  end
end
