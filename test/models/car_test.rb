require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # test for all empty (presence)
  test "for all empty" do
    c = Car.create({:make_id => nil, :model => "", :vin => "", :part_ids => []})
    refute c.valid?
    refute c.save
    assert_equal({:make=>["must exist", "can't be blank"], :model=>["can't be blank"], :vin=>["can't be blank"], :parts=>["can't be blank"]}, c.errors.messages)
  end

  # test for empty make (presence)
  test "for empty make" do
    c = Car.create({:make_id => nil, :model => cars(:one).model, :vin => "A1", :part_ids => [parts(:one).id]})
    refute c.valid?
    refute c.save
    assert_equal({:make=>["must exist", "can't be blank"]}, c.errors.messages)
  end

  # test for empty model (presence)
  test "for empty model" do
    c = Car.create({:make => makes(:one), :model => "", :vin => "B2", :part_ids => [parts(:one).id]})
    refute c.valid?
    refute c.save
    assert_equal({:model=>["can't be blank"]}, c.errors.messages)
  end

  # test for empty vin (presence)
  test "for empty vin" do
    c = Car.create({:make => makes(:one), :model => cars(:one).model, :vin => "", :part_ids => [parts(:one).id]})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["can't be blank"]}, c.errors.messages)
  end

  # test for existing vin (uniqueness)
  test "for existing vin" do
    c = Car.create({:make => makes(:one), :model => cars(:one).model, :vin => cars(:one).vin, :part_ids => [parts(:one).id]})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["has already been taken"]}, c.errors.messages)
  end

  # test for valid vin (regex)
  test "for valid vin" do
    c = Car.create({:make => makes(:one), :model => cars(:one).model, :vin => "C#", :part_ids => [parts(:one).id]})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["may only contain A-Z and 0-9"]}, c.errors.messages)
  end

  # test for parts empty (presence)
  test "for parts empty" do
    c = Car.create({:make => makes(:one), :model => cars(:one).model, :vin => "C3", :part_ids => []})
    refute c.valid?
    refute c.save
    assert_equal({:parts=>["can't be blank"]}, c.errors.messages)
  end

  # test for valid car
  test "for valid car" do
    c = Car.create({:make => makes(:one), :model => cars(:one).model, :vin => "D4", :part_ids => [parts(:one).id, parts(:two).id]})
    assert c.valid?
    assert c.save
  end
end
