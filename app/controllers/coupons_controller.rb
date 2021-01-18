class CouponsController < ApplicationController
    def inactivate
        @coupon = Coupon.find(params[:id])
        @coupon.inactive!
        flash[:success] = t('.success') #I18n coupon
        redirect_to @coupon.promotion
    end
end