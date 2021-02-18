require 'rails_helper'

feature 'Admin edits a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')

    login_as user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Editar')
  end

  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'fulana@locaweb.com.br', password: '123456')

    login_as user
    visit promotions_path
    click_on 'Editar'

    fill_in 'Nome', with: 'Cyber Tuesday'
    fill_in 'Descrição', with: 'Promoção de Cyber Tuesday'
    fill_in 'Código', with: 'CYBERT20'
    fill_in 'Desconto', with: '20'
    fill_in 'Quantidade de cupons', with: '100'
    fill_in 'Data de término', with: '22/12/2034'
    click_on 'Concluído'

    visit promotions_path

    expect(page).to have_content('Cyber Tuesday')
    expect(page).to have_content('Promoção de Cyber Tuesday')
    expect(page).to have_content('20')
  end
end
