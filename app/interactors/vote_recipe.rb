class VoteRecipe
  include Interactor

  def call
    score = context.score.to_i
    @vote = Vote.where(recipe_id: context.recipe_id, user_id: context.user.id).first
    if (1..5).include?(score)
      unless @vote
        @vote = Vote.new(recipe_id: context.recipe_id, user_id: context.user.id)
      end
      @vote.rating = score
      @vote.save
    elsif score == 0
      @vote.destroy if @vote
    end
  end
end
