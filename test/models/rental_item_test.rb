require "test_helper"

class RentalItemTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(name: "Audio")
    @client = Client.create!(name: "Client", cpf_cnpj: "98765432100", email: "c@test.com", phone: "11888888888", address: "Av Teste, 2")
    @event = Event.create!(name: "Event", start_date: Date.today, end_date: Date.today + 3, local: "SP")
    @user = User.create!(name: "User", email: "u@test.com", user: "user1", password: "password123")
    @rental = Rental.create!(client: @client, event: @event, user: @user, start_date: Date.today, end_date: Date.today + 2)
    @equipment = Equipment.create!(name: "Speaker", daily_value: 50.0, category: @category, status: :available)
  end

  test "valid rental item is valid" do
    item = RentalItem.new(rental: @rental, equipment: @equipment, quantity: 1, daily_price: 50.0, subtotal: 100.0)
    assert item.valid?
  end

  test "requires quantity" do
    item = RentalItem.new(rental: @rental, equipment: @equipment, daily_price: 50.0)
    assert_not item.valid?
    assert_includes item.errors[:quantity], "can't be blank"
  end

  test "quantity must be greater than zero" do
    item = RentalItem.new(rental: @rental, equipment: @equipment, quantity: 0, daily_price: 50.0)
    assert_not item.valid?
  end

  test "requires daily_price" do
    item = RentalItem.new(rental: @rental, equipment: @equipment, quantity: 1)
    assert_not item.valid?
  end

  test "cannot add unavailable equipment" do
    @equipment.update!(status: :unavailable)
    item = RentalItem.new(rental: @rental, equipment: @equipment, quantity: 1, daily_price: 50.0)
    assert_not item.valid?
    assert_includes item.errors[:base], "Equipment 'Speaker' is not available for rental"
  end

  test "can add pending equipment" do
    @equipment.update!(status: :pending)
    item = RentalItem.new(rental: @rental, equipment: @equipment, quantity: 1, daily_price: 50.0, subtotal: 100.0)
    assert item.valid?
  end

  test "saving item updates rental total_value" do
    assert_nil @rental.total_value

    RentalItem.create!(rental: @rental, equipment: @equipment, quantity: 1, daily_price: 50.0, subtotal: 100.0)
    assert_equal 100.0, @rental.reload.total_value
  end

  test "destroying item updates rental total_value" do
    item = RentalItem.create!(rental: @rental, equipment: @equipment, quantity: 1, daily_price: 50.0, subtotal: 100.0)
    assert_equal 100.0, @rental.reload.total_value

    item.destroy
    assert_equal 0.0, @rental.reload.total_value
  end
end
