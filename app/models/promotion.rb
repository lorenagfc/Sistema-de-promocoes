class Promotion < ApplicationRecord
    has_many :coupons, dependent: :destroy
    
    validates :name,
              :code,
              :discount_rate,
              :coupon_quantity,
              :expiration_date,
              presence: true
    validates :code, uniqueness: true

# TODO gerar cupons faltantes. ja gerei 10 cupons, faltam 10

    def generate_coupons!
        raise 'Cupons já foram criados' if coupons.any?

        coupons.create_with(created_at: Time.now, updated_at: Time.now)
        Coupon.insert_all!(generate_coupons_code)

        #(1..coupon_quantity).each do |number|
            #coupons.create!(code: "#{code}-#{'%04d' % number}")
        #end
    end

    private

    def generate_coupons_code
        (1..coupon_quantity).map do |number|
            { code: "#{code}-#{'%04d' % number}" }
        end
    end

end
