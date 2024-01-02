-- show the best rated recipes
SELECT * FROM "recipes_info" ORDER BY "rating" DESC LIMIT 10;


-- searching for recipes tagged as suitable for dinner
SELECT *
FROM "recipes_info"
WHERE "id" IN (
  SELECT "recipe_id"
  FROM "tags"
  WHERE "tag" ILIKE '%dinner%'
)
ORDER BY "rating" DESC
LIMIT 10;


-- searching instructions based on word search in recipe name
SELECT "recipes"."name", "instructions"."step", "instructions"."instruction"
FROM "instructions"
JOIN "recipes" ON "instructions"."recipe_id" = "recipes"."id"
WHERE "recipes"."name" ILIKE '%pepe%'
ORDER BY "recipes"."name", "instructions"."step";


-- searching recipe ingredients based on word found in recipe name
SELECT "recipe_id", "recipe name", "ingredient", "amount", "unit", "group", "kcal", "carbohydrate", "protein", "fats", "fiber"
FROM "recipe_ingredients_info"
WHERE "recipe name" ILIKE '%pepe%'
ORDER BY "recipe name", "ingredient";


-- show recipes rated by "jane"
SELECT "users"."username", "recipes"."name", "users_recipes_rating"."rating"
FROM "recipes"
JOIN "users_recipes_rating" ON "recipes"."id" = "users_recipes_rating"."recipe_id"
JOIN "users" ON "users_recipes_rating"."user_id" = "users"."id"
WHERE "users"."username" ILIKE '%jane%'
ORDER BY "users"."username", "users_recipes_rating"."rating" DESC;


-- insert or update user's rating of a recipe
WITH "rating_user" AS (
  SELECT "id" FROM "users" WHERE "username" = 'janesmith'
),
"rated_recipe" AS (
  SELECT "id" FROM "recipes" WHERE "name" = 'Gnocchi cacio e pepe'
)
INSERT INTO "users_recipes_rating" ("user_id", "recipe_id", "rating")
SELECT "rating_user"."id", "rated_recipe"."id", 4
FROM "rating_user", "rated_recipe"
ON CONFLICT ("user_id", "recipe_id") DO UPDATE
SET "rating" = 4;

-- for simplyfied inserting or updating user's rating of a recipe we call procedure insert_or_update_rating(username, recipe name, rating0)
-- explicit types of these inputs must be added
CALL "insert_or_update_rating"('janesmith'::VARCHAR(127), 'White fish with sesame noodles'::VARCHAR(511), 10::SMALLINT);


-- propose 10 recipes that 'janesmith' has not rated but might like based on her ingredient preferences in rated recepes. The result will be ordered by the expected preference in descending order.
WITH "unrated_recipes" AS (
    -- Get the recipes that the user has not rated yet
    SELECT "id", "name"
    FROM "recipes"
    WHERE "id" NOT IN (
      SELECT "recipe_id"
      FROM "users_recipes_rating"
      JOIN "users" ON "users_recipes_rating"."user_id" = "users"."id"
      WHERE "users"."username" = 'janesmith'
    )
),
"the_user_preference" AS (
  SELECT
    "users_preference"."ingredient_id",
    "users_preference"."prerefential_ratio"
  FROM "users_preference"
  JOIN "users" ON "users_preference"."user_id" = "users"."id"
  WHERE "users"."username" = 'janesmith'
)
SELECT
    "unrated_recipes"."id",
    "unrated_recipes"."name" AS "recipe name",
    COALESCE(ROUND(SUM("the_user_preference"."prerefential_ratio")/COUNT("recipe_ingredients"."ingredient_id"), 2), 0) AS "expected preference"
FROM "unrated_recipes"
JOIN "recipe_ingredients" ON "unrated_recipes"."id" = "recipe_ingredients"."recipe_id"
LEFT JOIN "the_user_preference" ON "recipe_ingredients"."ingredient_id" = "the_user_preference"."ingredient_id"
GROUP BY "unrated_recipes"."id", "unrated_recipes"."name"
ORDER BY "expected preference" DESC
LIMIT 10;


-- show ingredient rating of the user (janesmith)
SELECT "users"."username", "ingredients"."name", "users_preference"."prerefential_ratio"
FROM "users_preference"
JOIN "users" ON "users_preference"."user_id" = "users"."id"
JOIN "ingredients" ON "users_preference"."ingredient_id" = "ingredients"."id"
WHERE "users"."username" = 'janesmith'
ORDER BY "users_preference"."prerefential_ratio" DESC, "ingredients"."name";
