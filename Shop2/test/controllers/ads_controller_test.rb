require 'test_helper'

class AdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get ads_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_url
    assert_response :success
  end

  test "should create ad" do
    assert_difference('Ad.count') do
      post ads_url, params: { ad: { description: @ad.description, email: @ad.email, name: @ad.name, price: @ad.price, seller_id: @ad.seller_id, url_img: @ad.url_img } }
    end

    assert_redirected_to ad_path(Ad.last)
  end

  test "should show ad" do
    get ad_url(@ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_url(@ad)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should update ad" do
    patch ad_url(@ad), params: { ad: { description: @ad.description, email: @ad.email, name: @ad.name, price: @ad.price, seller_id: @ad.seller_id, url_img: @ad.url_img } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should destroy ad" do
    assert_difference('Ad.count', -1) do
      delete ad_url(@ad)
    end

    assert_redirected_to ads_path
  end
end
