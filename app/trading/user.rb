 module Trading

  class User
    #generate getter and setter for name and amount_of_credits
    attr_accessor :name, :amount_of_credits, :list_of_items

    #factory method
    def self.named(name)
      user = self.new
      user.name = name
      user
    end

    #initialize
    def initialize
      self.amount_of_credits = 100
      self.list_of_items = Array.new
    end

    #Oder nur eine Liste mit aktiven. item wird aktiv, wenn es in die Liste reinkommt.
    def add_new_item(name, price)
      item = Trading::Item.named(name, price, self)
      list_of_items.push(item)
    end

    #make an item active
    def offer_an_item(item)
      item.status = true
    end

    def list_items
      list_of_active_items = list_of_items.reject {|item| item.status == false }
      list_of_active_items.each {|item| print(item)}
    end

    def buy_item(item)
      if item.status == true   && self.amount_of_credits >= item.price
        previous_owner = item.owner
        item.status = false
        item.owner = self
        list_of_items.push(item)
        self.amount_of_credits = amount_of_credits - item.price
        previous_owner.sell_item(item)
      end
      if item.status == false
        print('Item is not active!')
      end
      if self.amount_of_credits < item.price
        print('Not enough money!')
      end
    end

    def sell_item(item)
      self.amount_of_credits = amount_of_credits + item.price
      self.list_of_items.delete(item)
    end
  end
end
