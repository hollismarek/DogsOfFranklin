require 'test_helper'

class AnimalBiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal_bio = animal_bios(:one)
  end

  test "should get index" do
    get animal_bios_url
    assert_response :success
  end

  test "should get new" do
    get new_animal_bio_url
    assert_response :success
  end

  test "should create animal_bio" do
    assert_difference('AnimalBio.count') do
      post animal_bios_url, params: { animal_bio: { age: @animal_bio.age, breed: @animal_bio.breed, details: @animal_bio.details, fears: @animal_bio.fears, images: @animal_bio.images, likes: @animal_bio.likes, name: @animal_bio.name } }
    end

    assert_redirected_to animal_bio_url(AnimalBio.last)
  end

  test "should show animal_bio" do
    get animal_bio_url(@animal_bio)
    assert_response :success
  end

  test "should get edit" do
    get edit_animal_bio_url(@animal_bio)
    assert_response :success
  end

  test "should update animal_bio" do
    patch animal_bio_url(@animal_bio), params: { animal_bio: { age: @animal_bio.age, breed: @animal_bio.breed, details: @animal_bio.details, fears: @animal_bio.fears, images: @animal_bio.images, likes: @animal_bio.likes, name: @animal_bio.name } }
    assert_redirected_to animal_bio_url(@animal_bio)
  end

  test "should destroy animal_bio" do
    assert_difference('AnimalBio.count', -1) do
      delete animal_bio_url(@animal_bio)
    end

    assert_redirected_to animal_bios_url
  end
end
