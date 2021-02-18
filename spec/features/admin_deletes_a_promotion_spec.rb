require 'rails_helper'

feature 'Deletes a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')

    login_as user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Deletar')
  end

  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')

    login_as user
    visit promotions_path
    click_on 'Deletar'
    
    expect(page).not_to have_content('Cyber Monday')
  end
end
