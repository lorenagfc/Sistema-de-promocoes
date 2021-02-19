require 'rails_helper'

describe 'Coupon management' do
    context 'show' do
        it 'render coupon json with discount' do
            promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                                          code: 'CYBER15', discount_rate: 15,
                                          coupon_quantity: 100, expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')
            
            get "/api/v1/coupons/#{coupon.code}"

            expect(response).to have_http_status(:ok)
            expect(response.body).to include('15')
            expect(response.body).to include('22/12/2033')
        end

        it 'coupon not found' do
            get "/api/v1/coupons/NAOEXISTE1"

            expect(response).to have_http_status(:not_found)
            expect(response.body).to include('Cupom não encontrado')
        end

        xit 'coupon with expired promotion' do
            promotion = Promotion.create!(name: 'Vencida', description: 'Promoção vencida',
                                          code: 'VENCIDA', discount_rate: 15,
                                          coupon_quantity: 100, expiration_date: '22/12/2002')
            coupon = Coupon.create!(promotion: promotion, code: 'VENCIDA')
            
            expect(response).to have_http_status(400)
            expect(response.body).to include('Data expirada')
        end
    end

    context 'burn' do
      it 'change coupon status' do
        promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      coupon_quantity: 100, expiration_date: '22/12/2033')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
        
        post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDEM1' } }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Cupom utilizado com sucesso')
        expect(coupon.reload).to be_burn
        expect(coupon.reload.order).to eq('ORDEM1')
      end

      it 'coupon not found by code' do
        post "/api/v1/coupons/NAOEXISTE/burn", params: { order: { code: 'ORDEM1' } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Cupom não encontrado')
      end

      it 'params must exist' do
        promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      coupon_quantity: 100, expiration_date: '22/12/2033')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
        
        post "/api/v1/coupons/#{coupon.code}/burn", params: {  }

        expect(response).to have_http_status(:precondition_failed)
        
      end

      it 'order must exist' do
        promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      coupon_quantity: 100, expiration_date: '22/12/2033')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')
        
        post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: '' } }

        expect(response).to have_http_status(422)
      end

    end
end