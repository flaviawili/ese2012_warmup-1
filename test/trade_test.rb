
require './app/trading/user'
require './app/trading/item'
require 'test/unit'

class TradeTest < Test::Unit::TestCase

  def test_user_name
    user = Trading::User.named('Peter')
    assert_equal(user.name, 'Peter')
  end

  #Test requirements 2 and 3
  def test_amount_of_credits
    user1 = Trading::User.named('Peter')
    assert_equal(user1.amount_of_credits, 100)
    user1.amount_of_credits = user1.amount_of_credits - 10
    assert_equal(user1.amount_of_credits, 90)
  end

  #Test requirements 4-7
  def test_item_requirements
    user1 = Trading::User.named('Peter')
    item = Trading::Item.named('Cookies', 3, user1)
    assert_equal(item.name, 'Cookies')
    assert_equal(item.price, 3)
    assert_equal(item.status, false)
    assert_equal(item.owner, user1)
  end

  #Test add_new_item method  (requirement 8)
  def test_add_new_item
    user = Trading::User.named('Peter')
    user.add_new_item('Cookies', 3)
    assert_equal(user.list_of_items[0].name,'Cookies')
    assert_equal(user.list_of_items[0].price,3)
    assert_equal(user.list_of_items[0].owner.name, 'Peter')
    assert_equal(user.list_of_items[0].status, false)
  end

  #Test list_items method (requirement 9)
  def test_list_item
    user = Trading::User.named('Peter')
    user.add_new_item('Cookies', 3)
    user.add_new_item('Sandwich', 6)
    user.add_new_item('Cola', 2)
    user.offer_an_item(user.list_of_items.fetch(2))
    active_items = user.list_items
    assert_equal(active_items.length, 1)
    assert_equal(active_items[0].status, true)
    assert_equal(active_items[0].name, 'Cola')
  end

  #Test last requirement
  def test_credit_and_owner
      user1 = Trading::User.named('Peter')
      assert_equal(user1.amount_of_credits, 100)
      user2 = Trading::User.named('Paul')
      item1 = Trading::Item.named('Cookies', 3, user2)
      user2.offer_an_item(item1)
      user1.buy_item(item1)
      assert_equal(user1.amount_of_credits, 97)
      assert_equal(item1.owner, user1)

  end

  #Test last requirement
  def test_enough_credits
    user1 = Trading::User.named('Peter')
    user2 = Trading::User.named('Paul')
    item1 = Trading:: Item.named('Bike', 150, user2)
    user2.offer_an_item(item1)
    user1.buy_item(item1)
    assert_equal(item1.owner, user2)
    assert_equal(user1.amount_of_credits, 100)
    assert_equal(user2.amount_of_credits, 100)

  end

  #Test last requirement
  def test_status
    user1 = Trading::User.named('Peter')
    user2 = Trading::User.named('Paul')
    item1 = Trading::Item.named('Cookies', 3, user2)
    user1.buy_item(item1)
    assert_equal(item1.owner, user2)

  end


end