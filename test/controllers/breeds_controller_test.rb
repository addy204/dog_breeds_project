require "test_helper"

class BreedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get breeds_index_url
    assert_response :success
  end

  test "should get show" do
    get breeds_show_url
    assert_response :success
  end

  test "should get new" do
    get breeds_new_url
    assert_response :success
  end

  test "should get create" do
    get breeds_create_url
    assert_response :success
  end

  test "should get edit" do
    get breeds_edit_url
    assert_response :success
  end

  test "should get update" do
    get breeds_update_url
    assert_response :success
  end

  test "should get destroy" do
    get breeds_destroy_url
    assert_response :success
  end
end
