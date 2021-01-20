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

        #@coupon = Coupon.find_by(code: params[:code])
        #json = { discount: @coupon.promotion.discount_rate,
                 #expiration_date: I18n.l(@coupon.promotion.expiration_date) }
        #render json: @json, status :ok

        @coupon = Coupon.find_by(code: params[:code])
        return render json: 'Cupom não encontrado', status: :not_found if @coupon.nil?
        render json: @coupon.as_json status: :ok #as_json pode ser removido pois é padrao
      
        #ao invés do return,
        #rescue ActiveRecord::RecordNotFound
          #render json: 'Cupom não encontrado', status: :not_found
        #end
      end
    end
  end
end