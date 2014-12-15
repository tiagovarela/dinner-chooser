# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Recipe.create([
  {
    name: 'Broiled Sesame Cod',
    submitter: 'Tiago',
    url: 'http://allrecipes.com/recipe/broiled-sesame-cod/'
  },
  {
    name: 'Grilled Cod',
    submitter: 'Tiago',
    url: 'http://allrecipes.com/recipe/grilled-cod/'
  },
  {
    name: 'Perfect Turkey',
    submitter: 'Pedro',
    url: 'http://allrecipes.com/recipe/perfect-turkey/'
  },
])

sesame_recipe = Recipe.where(name: 'Broiled Sesame Cod').first!
Vote.create(recipe: sesame_recipe, up: true)
Vote.create(recipe: sesame_recipe, up: true)
Vote.create(recipe: sesame_recipe, up: true)
Vote.create(recipe: sesame_recipe, up: true)
Vote.create(recipe: sesame_recipe, up: false)
Vote.create(recipe: sesame_recipe, up: false)

turkey_recipe = Recipe.where(name: 'Perfect Turkey').first!
Vote.create(recipe: turkey_recipe, up: true)
Vote.create(recipe: turkey_recipe, up: true)
Vote.create(recipe: turkey_recipe, up: true)
Vote.create(recipe: turkey_recipe, up: false)
Vote.create(recipe: turkey_recipe, up: false)

grilled_recipe = Recipe.where(name: 'Grilled Cod').first!
Vote.create(recipe: grilled_recipe, up: true)
Vote.create(recipe: grilled_recipe, up: false)
Vote.create(recipe: grilled_recipe, up: false)
