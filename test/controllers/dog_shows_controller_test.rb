require "test_helper"

class DogShowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dog_shows_index_url
    assert_response :success
  end

  test "should get show" do
    get dog_shows_show_url
    assert_response :success
  end

  test "should get new" do
    get dog_shows_new_url
    assert_response :success
  end

  test "should get create" do
    get dog_shows_create_url
    assert_response :success
  end

  test "should get edit" do
    get dog_shows_edit_url
    assert_response :success
  end

  test "should get update" do
    get dog_shows_update_url
    assert_response :success
  end

  test "should get destroy" do
    get dog_shows_destroy_url
    assert_response :success
  end
end
