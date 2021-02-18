class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { active: 0, inactive: 20, burn: 10 }
  validates :order, presence: true, on: :coupon_burn

  def title
    "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super(options.merge(methods: %i[discount_rate expiration_date],
          only: %i[])) #juntando hashs
  end

  def burn!(order) #para obrigar a ter order
    self.order = order
    self.status = :burn
    save!(context: :coupon_burn)
    
    #raise ActiveRecord::RecordInvalid unless order.present?
    #update(order: order, status: :burn)
  end

  def discount_rate
    promotion.discount_rate
  end

  def expiration_date
    I18n.(promotion.expiration_date)
  end
end
