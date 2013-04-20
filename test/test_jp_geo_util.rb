# -*- coding: utf-8 -*-

#require File.expand_path(__dir__) + '/test_helper'
require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class Application
  include JpGeoUtil::Core
end

class TestJpGeoUtil < Test::Unit::TestCase

  def setup
    @obj = Application.new
  end

  # TODO make test for each method

  # TODO more test case
  def test_tokyo2wgs84
    %w|
      139.74864721298218
      35.655448143244484

      139.74544056055004
      35.65867706344049
    |.each_slice(4) do |ar|
      ret = @obj.tokyo2wgs84({:lat=>ar[0],:lng=>ar[1]})
      assert_equal(
        [ar[2].to_f, ar[3].to_f],
        [ret[:lat],  ret[:lng]])
    end
  end

  # TODO more test case
  def test_total_sec_to_hms
    %w|
      502779.393
      139.393939

      128135.353
      35.353535
    |.each_slice(2) do |ar|
      assert_equal(
        ar[1].to_f,
        @obj.total_sec_to_hms(ar[0].to_f))
    end
  end

  # TODO more test case
  def test_hms_to_hnum
    %w|
      139.393939
      139.66094166666667

      35.353535
      35.593152777777775
    |.each_slice(2) do |ar|
      assert_equal(
        ar[1].to_f,
        @obj.hms_to_hnum(ar[0].to_f))
    end
  end

  def test_jp_total_sec_to_wgs84
    %w|
      509489.2296
      155205.9144

      141.52108583806316
      43.11521515768384
    |.each_slice(4) do |ar|
      ret = @obj.jp_total_sec_to_wgs84(
        :x => ar[0].to_f,
        :y => ar[1].to_f)

      assert_equal(
        [ar[2].to_f, ar[3].to_f],
        [ret[:lat],  ret[:lng] ])
    end
  end

  def test_parse_location_argument
    assert_raise do
      @obj.parse_location_argument()
    end
    assert_raise do
      @obj.parse_location_argument(:x=>1)
    end
    assert_raise do
      @obj.parse_location_argument(:x=>1,:lng=>1)
    end
    assert_raise do
      @obj.parse_location_argument(:x=>'',:y=>1)
    end
    assert_equal(
      [1.0, 2.0],
      @obj.parse_location_argument(:x=>1.0,:y=>2.0))
    assert_equal(
      [1.1, 2.1],
      @obj.parse_location_argument(:x=>"1.1",:y=>"2.1"))
    assert_equal(
      [1.1, 2.1],
      @obj.parse_location_argument(:lat=>"1.1",:lng=>"2.1"))
  end

end
