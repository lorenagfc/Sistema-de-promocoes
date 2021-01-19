module Api
  module v1
    class CouponsController < ApiController
      def show
        # achar o cupom
        #@coupon = Coupon.find_by(code: params[:code])
        # transformar o cupom em json
        #@json = @coupon.to_json
        # mandar o cupom pelo render json
        #render json: @json, status :ok #sem view

        @coupon = Coupon.find_by(code: params[:code])
        json = { discount: @coupon.promotion.discount_rate,
                 expiration_date: I18n.l(@coupon.promotion.expiration_date) }
        render json: @json, status :ok
      end
    end
  end
end