require 'test_helper'

class BiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bio = bios(:one)
  end

  test "should get index" do
    get bios_url
    assert_response :success
  end

  test "should get new" do
    get new_bio_url
    assert_response :success
  end

  test "should create bio" do
    assert_difference('Bio.count') do
      post bios_url, params: { bio: { age: @bio.age, breed: @bio.breed, details: @bio.details, fears: @bio.fears, likes: @bio.likes, name: @bio.name } }
    end

    assert_redirected_to bio_url(Bio.last)
  end

  test "should show bio" do
    get bio_url(@bio)
    assert_response :success
  end

  test "should get edit" do
    get edit_bio_url(@bio)
    assert_response :success
  end

  test "should update bio" do
    patch bio_url(@bio), params: { bio: { age: @bio.age, breed: @bio.breed, details: @bio.details, fears: @bio.fears, likes: @bio.likes, name: @bio.name } }
    assert_redirected_to bio_url(@bio)
  end

  test "should destroy bio" do
    assert_difference('Bio.count', -1) do
      delete bio_url(@bio)
    end

    assert_redirected_to bios_url
  end
end
