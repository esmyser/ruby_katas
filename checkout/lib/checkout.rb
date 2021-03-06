require 'pry'
class Checkout

  attr_accessor :items, :prices_and_offers

  def initialize(prices_and_offers)
    @prices_and_offers = prices_and_offers
    @items = {}
  end

  def scan(item)
    item = item.downcase.to_sym

    if @items[item]
      @items[item][:quantity] += 1
    else
      items[item] = prices_and_offers[item]
      items[item][:quantity] = 1
    end
  end

  def total
    total = 0

    unless @items.empty?
      @items.each do |item_key, item_values|
        item_quantity = item_values[:quantity]
        item_price = item_values[:price]

        if item_values[:offers]
          deal_threshold = item_values[:offers][:quantity]
          deal_price = item_values[:offers][:price]
          number_of_deals = item_quantity / deal_threshold
          items_after_deal = item_quantity % deal_threshold
        end

        if item_values[:offers] && item_quantity >= deal_threshold
          total += deal_price * number_of_deals
          total += item_price * items_after_deal
        else
          total += item_price * item_quantity
        end
      end
    end

    total
  end

end
