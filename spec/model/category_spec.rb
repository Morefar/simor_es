require 'spec_helper'

describe Category do
  it 'is invalid if there is another category with the same name' do
    cat1 = Category.create(name: 'Financial')
    cat2 = Category.create(name: 'Operational')
    cat3 = Category.new(name: 'Financial')
    expect(cat3).to have(1).errors_on(:name)
  end

  it "is invalid if a category has an empty name" do
    cat = Category.new(name: '')
    expect(cat).to have(3).errors_on(:name)
  end

  it 'must have between 2 and 20 letters in the name' do
    cat1 = Category.new(name: 'Financial')
    cat2 = Category.new(name: 'a')
    cat3 = Category.new(name: 'kkjhasiuhdjnviuhekjsuenu1243')
    expect(cat1).to be_valid
    expect(cat2).to have(1).errors_on(:name)
    expect(cat3).to have(2).errors_on(:name)
  end
end
