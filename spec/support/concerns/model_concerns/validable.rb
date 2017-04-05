shared_examples_for 'validable' do
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
