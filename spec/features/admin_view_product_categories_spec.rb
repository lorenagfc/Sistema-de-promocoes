require 'rails_helper'

feature 'Admin view product categories' do
    scenario 'successfully' 
        ProductCategory.create! (name: 'Hospedagem', code: 'HOSP')
        ProductCategory.create! (name: 'E-mail', code: 'EMAIL')
    
        visit root_path
        click_on 'Categorias de produto'

        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('E-mail')
        expect(page).to have_content('EMAIL')
    end
end