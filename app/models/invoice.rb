class Invoice < ActiveRecord::Base
  has_many :line_items
  belongs_to :contract

  after_save :create_line_items

  def create_line_items
    price = self.contract.try(:rent_phases).try(:first).try(:price).to_f
    invoice_end_date = self.end_date
    invoice_start_date = self.start_date
    diff_day = (invoice_end_date.day + 1) - (invoice_start_date).day
    if diff_day == 0
      (invoice_end_date.month - invoice_start_date.month).times do |mon|

        line_item_start_date = invoice_start_date + (mon-1).month
        line_item_end_date = (invoice_start_date + 1.month - 1.day) + (mon-1).month

        line_item_query = {
          start_date: line_item_start_date,
          end_date: line_item_end_date,
          unit_price: price,
          units: "1个月",
          total: price,
          invoice_id: self.id
        }
        LineItem.create(line_item_query)
      end
    elsif diff_day > 0
      (invoice_end_date.month - invoice_start_date.month).times do |mon|

        line_item_start_date = invoice_start_date + (mon-1).month
        line_item_end_date = (invoice_start_date + 1.month - 1.day) + (mon-1).month

        line_item_query = {
          start_date: line_item_start_date,
          end_date: line_item_end_date,
          unit_price: price,
          units: "1个月",
          total: price,
          invoice_id: self.id
        }
        LineItem.create(line_item_query)
      end
      day = invoice_end_date - ((line_item_start_date rescue nil) || invoice_start_date)
      line_item_day_query = {
        start_date: (line_item_start_date rescue nil) || invoice_start_date,
        end_date: invoice_end_date,
        unit_price: (price * 12)/365.0,
        units: "#{day.to_i}天",
        total: (price * 12)/365.0 * day,
        invoice_id: self.id
      }
      LineItem.create(line_item_day_query)
    else
      diff_month = self.end_date.month - self.start_date.month
      diff_month = diff_month == 0 ? 0 : (diff_month - 1)
      diff_month.times do |mon|

        line_item_start_date = invoice_start_date + (mon-1).month
        line_item_end_date = (invoice_start_date + 1.month - 1.day) + (mon-1).month

        line_item_query = {
          start_date: line_item_start_date,
          end_date: line_item_end_date,
          unit_price: price,
          units: "1个月",
          total: price,
          invoice_id: self.id
        }
        LineItem.create(line_item_query)
      end
      day = invoice_end_date - ((line_item_start_date rescue nil) || invoice_start_date)
      line_item_day_query = {
        start_date: (line_item_start_date rescue nil) || invoice_start_date,
        end_date: invoice_end_date,
        unit_price: (price * 12)/365.0,
        units: "#{day.to_i}天",
        total: (price * 12)/365.0 * day,
        invoice_id: self.id
      }
      LineItem.create(line_item_day_query)
    end
  end
end
