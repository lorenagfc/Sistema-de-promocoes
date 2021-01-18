require 'rails_helper'

feature 'Admin generates coupons' do
    
    scenario 'with coupon quantity available' do
        promotion = Promotion.create!(name: 'Pascoa',
                                      coupon_quantity: 5,
                                      discount_rate: 10,
                                      code: 'PASCOA10',
                                      expiration_date: 1.day.from_now)
        user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')
    
        login_as user, scope: :user
        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        click_on 'Emitir cupons'

        expect(current_path).to eq(promotions_path(promotion))
        expect(page).to have_content('PASCOA10-001 (disponível)')
        expect(page).to have_content('PASCOA10-002 (disponível)')
        expect(page).to have_content('PASCOA10-003 (disponível)')
        expect(page).to have_content('PASCOA10-004 (disponível)')
        expect(page).to have_content('PASCOA10-005 (disponível)')
        expect(page).to have_content('Cupons gerados com sucesso')
        expect(page).to_not have_link('Emitir cupons')
    end

    scenario 'and coupons are already generated' do
        promotion = Promotion.create!(name: 'Pascoa',
                                      coupon_quantity: 5,
                                      discount_rate: 10,
                                      code: 'PASCOA10',
                                      expiration_date: 1.day.from_now)
        coupon = promotion.coupons.create(code: 'ABCD')
        user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')
    
        login_as user, scope: :user
        visit promotions_path(promotion)

        expect(page).not_to have_link('Emitir cupons')
        expect(page).to have_content(coupon.code)
    end
end