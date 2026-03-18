require "test_helper"

class EquipmentTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(name: "Lighting")
    @equipment = Equipment.new(name: "LED Par", daily_value: 30.0, category: @category)
  end

  test "valid equipment is valid" do
    assert @equipment.valid?
  end

  test "requires name" do
    @equipment.name = nil
    assert_not @equipment.valid?
  end

  test "requires daily_value" do
    @equipment.daily_value = nil
    assert_not @equipment.valid?
  end

  test "daily_value cannot be negative" do
    @equipment.daily_value = -5
    assert_not @equipment.valid?
  end

  test "requires category" do
    @equipment.category = nil
    assert_not @equipment.valid?
  end

  test "default status is available" do
    @equipment.save!
    assert @equipment.available?
  end

  test "by_name scope finds by partial name" do
    @equipment.save!
    result = Equipment.by_name("LED")
    assert_includes result, @equipment
  end

  test "by_name scope is case insensitive via LIKE" do
    @equipment.save!
    result = Equipment.by_name("led")
    assert_includes result, @equipment
  end

  test "available_for_rental includes available equipment" do
    @equipment.save!
    assert_includes Equipment.available_for_rental, @equipment
  end

  test "available_for_rental includes pending equipment" do
    @equipment.update!(status: :pending)
    assert_includes Equipment.available_for_rental, @equipment
  end

  test "available_for_rental excludes unavailable equipment" do
    @equipment.update!(status: :unavailable)
    assert_not_includes Equipment.available_for_rental, @equipment
  end

  test "available_for_rental excludes rented equipment" do
    @equipment.update!(status: :rented)
    assert_not_includes Equipment.available_for_rental, @equipment
  end
end
