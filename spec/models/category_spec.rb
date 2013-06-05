require 'spec_helper'

describe Category do
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_length_of(:name).
              is_at_least(2).
              is_at_most(20) }
  it { should allow_value('Financiero').for(:name) }
  it { should_not allow_value('Financiero Importación').for(:name) }
  it { should_not allow_value('Financiero1').for(:name) }

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
