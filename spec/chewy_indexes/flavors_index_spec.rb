describe 'FlavorsdfsdsIndex' do
  # No need to cleanup Elasticsearch as requests are
  # stubbed in case of `update_index` matcher usage.
  describe 'flavor' do
    # We create several books with the same tag
    let(:flavor) { create(:flavor) }

    specify do
      # We expect that after modifying the tag name...
      expect do
        flavor.update_attributes(name: 'new flavor name')
      end.to update_index('flavors#flavor').and_reindex(flavor)
    end
  end
end
