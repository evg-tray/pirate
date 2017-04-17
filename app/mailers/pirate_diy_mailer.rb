class PirateDiyMailer < ApplicationMailer

  def notify(user, recipe)
    @recipe = recipe
    @user = user
    mail(to: @user.email, subject: "Новый рецепт: #{@recipe.name}")
  end
end
