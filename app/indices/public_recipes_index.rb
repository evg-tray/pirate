ThinkingSphinx::Index.define :recipe, with: :active_record do
  indexes name

  where "public = true OR pirate_diy = true"
  has pirate_diy, type: :boolean
end
