require 'rails_helper'

feature 'Admin inactivate coupon' do
    scenario 'successfully' do
        promotion = Promotion.create!(name: 'Cyber Monday', description: 'Promoção de Cyber Monday',
                        code: 'CYBER15', discount_rate: 15,
                        coupon_quantity: 100, expiration_date: '22/12/2033')
        coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
        user = User.create!(email: "fulana@locaweb.com.br", password: '123456')

        login_as user
        visit promotions_path(promotion)
        click_on 'Descartar cupom'

        expect(page).to have_content('Cupom cancelado com sucesso')
        expect(page).to have_content('CYBER15-001 (cancelado)')
        expect(pages).not_to have_link('Descartar cupom')
        expect(coupon.reload).to be_inactive #atualizar do banco o status
    end

end