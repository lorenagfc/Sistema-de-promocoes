require 'rails_helper'

RSpec.describe Coupon, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  xcontext '#title' do
    it  'status default' do
      coupon = Coupon.new(code: 'NATAL10-0001')
      expect(coupon.title).to eq('NATAL10-0001 (disponível)')
    end

    it  'status active' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :active)
      expect(coupon.title).to eq('NATAL10-0001 (disponível)')
    end

    it  'status inactive' do
      
    end
  end
end
