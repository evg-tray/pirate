RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(10).is_at_most(200) }
    it { should validate_numericality_of(:amount).only_integer.is_greater_than(0) }
    it { should validate_numericality_of(:strength).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:pg).
        only_integer.
        is_greater_than_or_equal_to(0).
        is_less_than_or_equal_to(100)
    }
    it { should validate_numericality_of(:vg).
        only_integer.
        is_greater_than_or_equal_to(0).
        is_less_than_or_equal_to(100)
    }
    it { should validate_numericality_of(:nicotine_base).
        only_integer.
        is_greater_than_or_equal_to(0).
        is_less_than_or_equal_to(100)
    }
  end

  describe 'associations' do
    it { should have_many(:flavors_recipes).inverse_of(:recipe) }
    it { should have_many(:flavors).through(:flavors_recipes) }
    it { should accept_nested_attributes_for(:flavors_recipes).allow_destroy(true) }
  end
end
