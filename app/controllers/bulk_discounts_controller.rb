class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayService.name_and_date_next_three_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discounts_params)
    if bulk_discount.save(bulk_discounts_params)
      redirect_to merchant_bulk_discounts_path(merchant)
      flash.notice = 'Your bulk discount has been successfully created.'
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash.notice = 'Please fill in the missing fields.'
    end
  end
  
  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    if bulk_discount.update(bulk_discounts_params)
      redirect_to merchant_bulk_discount_path(merchant.id, bulk_discount.id)
      flash.notice = 'Your bulk discount has been updated successfully'
    else
      redirect_to edit_merchant_bulk_discount_path(merchant, bulk_discount.id)
      flash.notice = 'Please fill in all fields with a number.'
    end
  end

  private
  
  def bulk_discounts_params
    params.permit(:quantity_threshold, :percentage)
  end
end