require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get events" do
    get categories_events_url
    assert_response :success
  end

  test "should get reviews" do
    get categories_reviews_url
    assert_response :success
  end

  test "should get attendances" do
    get categories_attendances_url
    assert_response :success
  end

  test "should get users" do
    get categories_users_url
    assert_response :success
  end

  test "should get teammate_links" do
    get categories_teammate_links_url
    assert_response :success
  end

end
