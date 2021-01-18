class Promotion < ApplicationRecord
    has_many :coupons, dependent: :destroy
    
    validates :name,
              :code,
              :discount_rate,
              :coupon_quantity,
              :expiration_date,
              presence: true
    validates :code, uniqueness: true

    def generate_coupons!
        codes = (1..coupon_quantity).map do |number|
                { code: "#{code}-#{'%04d' % number}",
                created_at: Time.now, updated_at: Time.now,
                promotion_id: id }
        end
        Coupon.insert_all!(codes)

        #(1..coupon_quantity).each do |number|
            #coupons.create!(code: "#{code}-#{'%04d' % number}")
        #end
    end
end
