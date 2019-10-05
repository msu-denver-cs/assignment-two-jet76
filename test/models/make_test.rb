require 'test_helper'

class MakeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # test for empty name and country (presence)
  test "for empty name and country" do
    m = Make.create({:name => "", :country =>""})
    refute m.valid?
    refute m.save
    assert_equal({:name=>["can't be blank"], :country=>["can't be blank"]}, m.errors.messages)
  end

  # test for empty name (presence)
  test "for empty name" do
    m = Make.create({:name => "", :country => makes(:one).country})
    refute m.valid?
    refute m.save
    assert_equal({:name=>["can't be blank"]}, m.errors.messages)
  end

  # test for name exists (uniqueness)
  test "for existing name" do
    m = Make.create({:name => makes(:one).name, :country => makes(:one).country})
    refute m.valid?
    refute m.save
    assert_equal({:name=>["has already been taken"]}, m.errors.messages)
  end

  # test for empty country (presence)
  test "for empty country" do
    m = Make.create({:name => "Honda", :country => ""})
    refute m.valid?
    refute m.save
    assert_equal({:country=>["can't be blank"]}, m.errors.messages)
  end

  # test for valid make
  test "for valid make" do
    m = Make.create({:name => "Ford", :country => "Pinto"})
    assert m.valid?
    assert m.save
  end
end
