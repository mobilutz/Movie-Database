require 'spec_helper'

describe Category do
  context 'Validations' do
    it 'should check for presence of name' do
      category = Category.new
      category.valid?.should be_false
    end

    it 'should check for uniqueness of name' do
      category = Category.create!(name: 'MyCategory')
      category2 = Category.new(name: 'MyCategory')
      category2.valid?.should be_false
    end
  end
end
