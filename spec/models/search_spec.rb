RSpec.describe Search do
  context '.results' do
    let(:query) { 'some query' }
    let(:params) { {page: '1', per_page: 5} }

    it 'calls escape request' do
      expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
      Search.results(query, 'all', '1')
    end

    it 'calls Recipe.search' do
      expect(Recipe).to receive(:search).with(query, params).and_call_original
      Search.results(query, 'all', '1')
    end
  end
end
