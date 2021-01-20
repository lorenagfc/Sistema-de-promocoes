require 'rails_helper'

describe 'Coupon management' do
    context 'show' do
        it 'render coupon json with discount'
        promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
        code: 'CYBER15', discount_rate: 15,
        coupon_quantity: 100, expiration_date: '22/12/2033')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
        
        get 'api/v1/coupon/#{coupon.code}'

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('15')
        expect(response.body).to include('22/12/2033')
    end

    it 'coupon not found'
        get 'api/v1/coupon/NAOEXISTE'

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Cupom não encontrado')
    end

    #TODO continuar
    it 'coupon with expired promotion'
        promotion = Promotion.create!(name: 'Vencida', description: 'Promoção vencida',
        code: 'VENCIDA', discount_rate: 15,
        coupon_quantity: 100, expiration_date: '22/12/2002')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
        

        #expect(response).to have_http_status(:not_found)
        #expect(response.body).to include('Cupom não encontrado')
    end
end