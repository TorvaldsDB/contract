class Contract < ActiveRecord::Base
  has_many :rent_phases
  has_many :invoices
  after_save :generate_invoices

  accepts_nested_attributes_for :rent_phases, allow_destroy: true
  accepts_nested_attributes_for :invoices, allow_destroy: true

  def generate_invoices
    length = self.rent_phases.count
    self.rent_phases.each_with_index do |rent_phase, index|
      total =
      if index == length -1
        diff_day = (rent_phase.end_date.day + 1) - (rent_phase.start_date).day
        if diff_day == 0
          ((rent_phase.end_date.year - rent_phase.start_date.year) * 12 +
          (rent_phase.end_date.month - rent_phase.start_date.month)) * rent_phase.price
        elsif diff_day > 0
          ((rent_phase.end_date.year - rent_phase.start_date.year) * 12 +
          (rent_phase.end_date.month - rent_phase.start_date.month)) * rent_phase.price +
          diff_day * (rent_phase.price * 12)/365.0
        else
          diff_month = rent_phase.end_date.month - rent_phase.start_date.month
          diff_month = diff_month == 0 ? 0 : (diff_month - 1)
          ((rent_phase.end_date.year - rent_phase.start_date.year) * 12 + diff_month) * rent_phase.price + (rent_phase.end_date - (rent_phase.start_date + diff_month)) *
           (rent_phase.price * 12)/365.0
        end
      else
        (rent_phase.price * rent_phase.cycles)
      end
        invoice_query = {
          start_date: rent_phase.start_date,
          end_date: rent_phase.end_date,
          due_date: Date.today,
          total: total,
          contract_id: self.id
        }
        Invoice.create(invoice_query)
    end
  end
end
