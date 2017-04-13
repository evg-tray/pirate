class UserSelectAdapter

  def self.select(query, page)
    @term = query
    if @term
      @list = User.where('username LIKE :term', term: "%#{@term}%")
    else
      @list = User.all
    end
    total_count = User.all.count
    {
        items: @list.map do |u|
          { text: u.username, id: u.id }
        end,
        total_count: total_count
    }
  end
end
