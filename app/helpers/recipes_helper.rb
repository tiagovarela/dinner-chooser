module RecipesHelper
  def already_voted?(recipe)
    previous_votes = []
    previous_votes = JSON.parse(cookies[:votes]) if cookies[:votes]
    previous_votes.include?(recipe.id)
  end
end
