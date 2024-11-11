# frozen_string_literal: true

require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Add two items to cart' do
  include Capybara::DSL

  before(:each) do
    visit('/')
    fill_in 'user-name', with: 'standard_user'
    fill_in 'password', with: 'secret_sauce'
    click_button 'Login'
  end

  it 'adds two items to cart and checks cart count' do
    find('#add-to-cart-sauce-labs-backpack').click
    find('#add-to-cart-sauce-labs-bolt-t-shirt').click

    cart_badge = find('.shopping_cart_link')
    expect(cart_badge).to have_selector('[data-test="shopping-cart-badge"]', text: '2')
  end
end
