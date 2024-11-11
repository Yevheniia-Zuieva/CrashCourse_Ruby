# frozen_string_literal: true

require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login' do
  include Capybara::DSL

  def login (username, password)
    visit('/')
    fill_in 'user-name', with: username
    fill_in 'password', with: password
    click_button 'Login'
  end

  it 'checks that error_user cannot log in' do
    login('error_user', 'secret_sauce')
    expect(page).to have_content('Epic sadface: Username and password do not match any user in this service')
  end

  it 'checks that locked_out_user cannot log in' do
    login('locked_out_user', 'secret_sauce')
    expect(page).to have_content('Epic sadface: Sorry, this user has been locked out.')
  end
end