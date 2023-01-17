require 'rails_helper'

RSpec.describe 'Bulk Discounts Show Page' do
  describe 'User story 4' do
    it 'displays the bulk discount quantity and percentage' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_2.bulk_discounts.create!(quantity_threshold: 15, percentage: 15)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_content(bulk_discount_1.id)
      expect(page).to have_content(bulk_discount_1.quantity_threshold)
      expect(page).to have_content(bulk_discount_1.percentage)
      expect(page).to_not have_content(bulk_discount_2.id)
      expect(page).to_not have_content(bulk_discount_2.quantity_threshold)
      expect(page).to_not have_content(bulk_discount_2.percentage)
    end
  end

  describe 'User story 5 (part 1)' do
    it 'has a link to the edit the bulk discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_link('Edit bulk discount')
    end
  end
end