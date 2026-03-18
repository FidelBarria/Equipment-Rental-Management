require "test_helper"

class RentalTest < ActiveSupport::TestCase
  def setup
    @client = Client.create!(name: "Test Client", cpf_cnpj: "12345678901", email: "client@test.com", phone: "11999999999", address: "Rua Teste, 1")
    @event = Event.create!(name: "Test Event", start_date: Date.today, end_date: Date.today + 3, local: "São Paulo")
    @user = User.create!(name: "Test User", email: "user@test.com", user: "testuser", password: "password123")
    @rental = Rental.new(
      client: @client,
      event: @event,
      user: @user,
      start_date: Date.today,
      end_date: Date.today + 2
    )
  end

  test "valid rental is valid" do
    assert @rental.valid?
  end

  test "requires client" do
    @rental.client = nil
    assert_not @rental.valid?
    assert_includes @rental.errors[:client_id], "can't be blank"
  end

  test "requires event" do
    @rental.event = nil
    assert_not @rental.valid?
  end

  test "requires user" do
    @rental.user = nil
    assert_not @rental.valid?
  end

  test "requires start_date" do
    @rental.start_date = nil
    assert_not @rental.valid?
  end

  test "requires end_date" do
    @rental.end_date = nil
    assert_not @rental.valid?
  end

  test "end_date must be after start_date" do
    @rental.end_date = @rental.start_date - 1
    assert_not @rental.valid?
    assert_includes @rental.errors[:end_date], "must be after the start date"
  end

  test "end_date equal to start_date is invalid" do
    @rental.end_date = @rental.start_date - 1.day
    assert_not @rental.valid?
  end

  test "total_value cannot be negative" do
    @rental.total_value = -10
    assert_not @rental.valid?
  end

  test "total_value can be nil" do
    @rental.total_value = nil
    assert @rental.valid?
  end

  test "default status is pending" do
    @rental.save!
    assert @rental.pending?
  end

  test "by_status scope filters correctly" do
    @rental.save!
    assert_includes Rental.by_status(:pending), @rental
    assert_not_includes Rental.by_status(:active), @rental
  end

  test "two rentals cannot share the same event" do
    @rental.save!
    duplicate = Rental.new(
      client: @client,
      event: @event,
      user: @user,
      start_date: Date.today,
      end_date: Date.today + 2
    )
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:event_id], "already has a rental associated"
  end

  test "calculate_total_value! sums rental_items subtotals" do
    @rental.save!
    category = Category.create!(name: "Test Category")
    equipment = Equipment.create!(name: "Speaker", daily_value: 50.0, category: category)

    @rental.rental_items.create!(equipment: equipment, quantity: 2, daily_price: 50.0, subtotal: 200.0)
    @rental.rental_items.create!(equipment: Equipment.create!(name: "Light", daily_value: 30.0, category: category),
                                  quantity: 1, daily_price: 30.0, subtotal: 60.0)

    @rental.calculate_total_value!
    assert_equal 260.0, @rental.reload.total_value
  end

  test "update_equipment_status marks equipment unavailable when active" do
    @rental.save!
    category = Category.create!(name: "Cat")
    equipment = Equipment.create!(name: "Projector", daily_value: 100.0, category: category, status: :available)
    @rental.rental_items.create!(equipment: equipment, quantity: 1, daily_price: 100.0, subtotal: 200.0)

    @rental.update!(status: :active)
    assert equipment.reload.unavailable?
  end

  test "update_equipment_status marks equipment available when completed" do
    @rental.save!
    category = Category.create!(name: "Cat2")
    equipment = Equipment.create!(name: "Mixer", daily_value: 80.0, category: category, status: :unavailable)
    @rental.rental_items.create!(equipment: equipment, quantity: 1, daily_price: 80.0, subtotal: 160.0)

    @rental.update!(status: :completed)
    assert equipment.reload.available?
  end

  test "update_equipment_status marks equipment available when cancelled" do
    @rental.save!
    category = Category.create!(name: "Cat3")
    equipment = Equipment.create!(name: "Camera", daily_value: 200.0, category: category, status: :unavailable)
    @rental.rental_items.create!(equipment: equipment, quantity: 1, daily_price: 200.0, subtotal: 400.0)

    @rental.update!(status: :cancelled)
    assert equipment.reload.available?
  end
end
