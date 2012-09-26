module Trading

  class Item

    #getter and setter
    attr_accessor :name, :price, :owner, :status

    #factory method
    def self.named(name, price, owner)
      item = self.new
      item.name = name
      item.price = price
      item.owner = owner
      item
    end

    #initialize
    def initialize
      self.status = false
    end

    def to_s
      "#{name}, #{price}"
    end

  end
end