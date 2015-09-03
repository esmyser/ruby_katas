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
        if item_values[:offers] && item_values[:quantity] % item_values[:offers].first == 0
          total += (item_values[:offers].last * (item_values[:offers].first / item_values[:quantity]))
        else
          total += (item_values[:price] * item_values[:quantity])
        end
      end
    end

    total
  end

end
