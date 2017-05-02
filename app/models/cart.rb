class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def add_item(item_id)

    new_item = line_items.find_by(item_id: item_id)
    if new_item
      new_item.quantity += 1

    else
    new_item = self.line_items.build(item_id:  item_id)
    end
    new_item
  end

  def total
    total = 0.00
    line_items.each do |line_item|
      total += line_item.quantity * line_item.item.price
    end
    total
  end

  def checkout
    update(status: "submitted")
    change_inventory

  end

  def change_inventory

     self.line_items.each do |line_item|
       line_item.item.inventory -= line_item.quantity
       line_item.item.save
     end
  end

end
