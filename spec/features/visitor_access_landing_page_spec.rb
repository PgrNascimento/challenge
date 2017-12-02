require 'rails_helper'

feature 'Visitor access landing page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Gama Game')
  end

  scenario 'and see the menu' do
    visit root_path

    expect(page).to have_css('header ul li', text: 'About')
    expect(page).to have_css('header ul li', text: 'Contact')
    expect(page).to have_css('header ul li', text: 'Login')
  end

  scenario 'and see a introduction text' do
    visit root_path

    expect(page).to have_css('h2', text: 'Come play with us!')
    expect(page).to have_content('Have you ever played Gama Game? It\'s a game of general knowledge questions and answers.')
    expect(page).to have_content('It used to be played at #gamagame, an IRC(Internet Relay Chat) channel in the Brasnet network, which no longer exists.')
    expect(page).to have_link('Start')
  end

  scenario 'and see footer text' do
    visit root_path

    expect(page).to have_css('footer', text: 'This game was developed as part of the hiring process for Plataformatec\'s Full Stack Web Software Developer position')
  end
end
