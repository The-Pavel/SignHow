require 'test_helper'

class GifsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gifs_index_url
    assert_response :success
  end

  test "should get show" do
    get gifs_show_url
    assert_response :success
  end

  test "should get new" do
    get gifs_new_url
    assert_response :success
  end

  test "should get create" do
    get gifs_create_url
    assert_response :success
  end

  test "should get edit" do
    get gifs_edit_url
    assert_response :success
  end

  test "should get update" do
    get gifs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get gifs_destroy_url
    assert_response :success
  end

end
