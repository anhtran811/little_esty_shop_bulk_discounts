require 'rails_helper'

RSpec.describe 'Delete bulk discount' do
  describe 'User story 3' do
    it 'can remove a bulk discount' do  
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)

      visit merchant_bulk_discounts_path(merchant_1)
      
      expect(page).to have_content("#{bulk_discount_1.id}")
      expect(page).to have_content("#{bulk_discount_2.id}")
      
      within("#bulk_discount-#{bulk_discount_1.id}") do
        click_link("Delete bulk discount #{bulk_discount_1.id}")
        
        expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1))
      end
      
      within("#bulk_discount-#{bulk_discount_2.id}") do
        expect(page).to have_link("Delete bulk discount #{bulk_discount_2.id}")
        expect(page).to_not have_link("Delete bulk discount #{bulk_discount_1.id}")
      end
      
      expect(page).to_not have_content("#{bulk_discount_1.id}")
      expect(page).to have_content("#{bulk_discount_2.id}")
    end
  end
end