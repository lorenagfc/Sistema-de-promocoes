require 'rails_helper'

feature 'User log in' do
    scenario 'and receive welcome message' do
        user = User.create!(email: 'fulana@locaweb.com.br', password:'123456')
    
        visit root_path
        click_on 'Login'
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Entrar'

        expect(current_path).to eq(root_path)
        #expect(page).to have_content('Login efetuado com sucesso')
        expect(page).to have_content(user.email)
        expect(page).to_not have_link('Login')
        expect(page).to have_link('Sair')
        #mostra links quando logado
    end

    scenario 'and log out' do
        user = User.create!(email: 'fulana@locaweb.com.br', password:'123456')
    
        visit root_path
        click_on 'Login'
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Entrar'
        click_on 'Sair'

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Saiu com sucesso')
        expect(page).to_not have_content(user.email)
        expect(page).to have_link('Login')
        expect(page).to_not have_link('Sair')
    end

    #registro
end