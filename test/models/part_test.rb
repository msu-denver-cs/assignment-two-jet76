require 'test_helper'

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # test for empty part name (presence)
  test "for empty name" do
    p = Part.create({:name => ""})
    refute p.valid?
    refute p.save
    assert_equal({:name=>["can't be blank"]}, p.errors.messages)
  end

  # test for part already exists (uniqueness)
  test "for existing name" do
    p = Part.create({:name => parts(:one).name})
    refute p.valid?
    refute p.save
    assert_equal({:name=>["has already been taken"]}, p.errors.messages)
  end

  # test for valid part
  test "for valid part" do
    p = Part.create({:name => "Warp Core"})
    assert p.valid?
    assert p.save
  end
end
