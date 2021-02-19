require 'rails_helper'

feature 'Admin view product categories' do
    scenario 'successfully' do
        ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
    
        visit root_path
        click_on 'Categorias de produto'

        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('E-mail')
        expect(page).to have_content('EMAIL')
    end

    xscenario 'and show empty message' do
        ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        ProductCategory.destroy(1)

        visit product_categories_path

        expect(page).not_to have_content('Hospedagem')
        expect(page).not_to have_content('HOSP')
        expect(page).to have_content('Não existe categoria de produtos cadastrada.')
    end

    xscenario 'and view details' do
        ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    
        visit product_categories_path
        click_on 'Hospedagem'

        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
    end
end