CREATE TABLE IF NOT EXISTS "users" (
  "id" BIGSERIAL PRIMARY KEY,
  "first_name" VARCHAR(63),
  "last_name" VARCHAR(127),
  "username" VARCHAR(127) UNIQUE,
  "password" VARCHAR(127),
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "recipes" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(511) UNIQUE NOT NULL,
  "url" TEXT UNIQUE,
  "photo" TEXT,
  "created_by" BIGINT REFERENCES "users"("id") ON DELETE SET NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "instructions" (
  "id" SERIAL PRIMARY KEY,
  "recipe_id" INTEGER NOT NULL REFERENCES "recipes"("id") ON DELETE CASCADE,
  "step" SMALLINT NOT NULL,
  "instruction" TEXT NOT NULL,
  "photo" TEXT,
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE ("recipe_id", "step")
);

CREATE TABLE IF NOT EXISTS "ingredients" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(511) UNIQUE NOT NULL,
  "kcal" DECIMAL(6,2),
  "protein" DECIMAL(6,2),
  "protein_unit" VARCHAR(31),
  "carbohydrate" DECIMAL(6,2),
  "carbohydrate_unit" VARCHAR(31),
  "sugar" DECIMAL(6,2),
  "sugar_unit" VARCHAR(31),
  "fats" DECIMAL(6,2),
  "fats_unit" VARCHAR(31),
  "saturated_fatty_acids" DECIMAL(6,2),
  "saturated_fatty_acids_unit" VARCHAR(31),
  "transfatty_acids" DECIMAL(6,2),
  "transfatty_acids_unit" VARCHAR(31),
  "monounsaturated_fats" DECIMAL(6,2),
  "monounsaturated_fats_unit" VARCHAR(31),
  "polyunsaturated_fats" DECIMAL(6,2),
  "polyunsaturated_fats_unit" VARCHAR(31),
  "cholesterol" DECIMAL(6,2),
  "cholesterol_unit" VARCHAR(31),
  "fiber" DECIMAL(6,2),
  "fiber_unit" VARCHAR(31),
  "salt" DECIMAL(6,2),
  "salt_unit" VARCHAR(31),
  "water" DECIMAL(6,2),
  "water_unit" VARCHAR(31),
  "calcium" DECIMAL(6,2),
  "calcium_unit" VARCHAR(31),
  "PHE" DECIMAL(6,2),
  "PHE_unit" VARCHAR(31),
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "recipe_ingredients" (
  "id" SERIAL PRIMARY KEY,
  "recipe_id" INTEGER NOT NULL REFERENCES "recipes"("id") ON DELETE CASCADE,
  "group" VARCHAR(255),
  "ingredient_id" INTEGER NOT NULL REFERENCES "ingredients" ("id") ON DELETE RESTRICT,
  "amount" DECIMAL(6,2) NOT NULL DEFAULT 1,
  "unit" VARCHAR(31) NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE ("recipe_id", "ingredient_id", "group")
);

CREATE TABLE IF NOT EXISTS "tags" (
  "id" BIGSERIAL PRIMARY KEY,
  "recipe_id" INTEGER NOT NULL REFERENCES "recipes"("id") ON DELETE CASCADE,
  "tag" VARCHAR(255) NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE("recipe_id", "tag")
);

CREATE TABLE IF NOT EXISTS "users_recipes_rating" (
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" BIGINT NOT NULL REFERENCES "users"("id") ON DELETE CASCADE,
  "recipe_id" INTEGER NOT NULL REFERENCES "recipes"("id") ON DELETE CASCADE,
  "rating" SMALLINT NOT NULL DEFAULT 0 CHECK ("rating" >= -10 AND "rating" <= 10),
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE ("user_id", "recipe_id")
);

CREATE TABLE IF NOT EXISTS "users_preference" (
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" BIGINT NOT NULL REFERENCES "users"("id") ON DELETE CASCADE,
  "ingredient_id" INTEGER NOT NULL REFERENCES "ingredients"("id") ON DELETE RESTRICT,
  "prerefential_ratio" DECIMAL(4,2) NOT NULL DEFAULT 0,
  "created_at" TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE ("user_id", "ingredient_id")
);


-- Creating indexes on most used columns in database
CREATE INDEX IF NOT EXISTS "recipe_name_index" ON "recipes" ("name");
CREATE INDEX IF NOT EXISTS "recipe_instructions_index" ON "instructions" ("recipe_id");
CREATE INDEX IF NOT EXISTS "recipe_ingredients_index" ON "recipe_ingredients" ("recipe_id", "ingredient_id");
CREATE INDEX IF NOT EXISTS "ingredients_name_index" ON "ingredients" ("name");
CREATE INDEX IF NOT EXISTS "recipe_tags_index" ON "tags" ("recipe_id", "tag");
CREATE INDEX IF NOT EXISTS "username_index" ON "users" ("username");
CREATE INDEX IF NOT EXISTS "recipe_rating_index" ON "users_recipes_rating"("user_id", "recipe_id");
CREATE INDEX IF NOT EXISTS "ingredients_preference_index" ON "users_preference"("user_id", "ingredient_id");


-- Function to calculate the preference based on ratings
CREATE OR REPLACE FUNCTION calculate_preference("user" BIGINT, "ingredient" INTEGER)
RETURNS DECIMAL(4,2) AS $$
DECLARE
  "ingredient_rating" DECIMAL(4,2);
BEGIN
  -- Calculation of user's preference of the ingredients based on the recipes in which the ingredient is contained
  SELECT COALESCE(SUM("rating")::DECIMAL/COUNT("rating"), 0)
  INTO "ingredient_rating"
  FROM "users_recipes_rating"
  WHERE "user_id" = "user"
  AND "recipe_id" IN (SELECT "recipe_id"
                      FROM "recipe_ingredients"
                      WHERE "ingredient_id" = "ingredient");
  RETURN "ingredient_rating";
END;
$$ LANGUAGE plpgsql;

-- Function to insert or update rating of ingredients
CREATE OR REPLACE FUNCTION update_user_preference()
RETURNS TRIGGER AS $$
  -- Getting the recipe_ingredient_ids for the rated recipe
DECLARE
  "recipe_ingredient_ids" INTEGER[];
BEGIN
  "recipe_ingredient_ids" := ARRAY(SELECT DISTINCT "ingredient_id"
                        FROM "recipe_ingredients"
                        WHERE "recipe_id" = NEW."recipe_id");

  -- Update or insert into users_preference for each ingredient_id in the currecntly rated recipe
  FOR i IN 1..array_length("recipe_ingredient_ids", 1) LOOP
    INSERT INTO "users_preference" ("user_id", "ingredient_id", "prerefential_ratio", "created_at", "updated_at")
    VALUES (NEW."user_id", "recipe_ingredient_ids"[i], calculate_preference(NEW."user_id", "recipe_ingredient_ids"[i]),
            NOW(), NOW())
    ON CONFLICT ("user_id", "ingredient_id") DO UPDATE
    SET "prerefential_ratio" = calculate_preference(NEW."user_id", "recipe_ingredient_ids"[i]),
        "updated_at" = NOW();
  END LOOP;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger to fill users_preference table
CREATE TRIGGER "users_recipes_rating_trigger"
AFTER INSERT OR UPDATE ON "users_recipes_rating"
FOR EACH ROW
EXECUTE FUNCTION update_user_preference();


-- Procedure for creating or updating users rating of a recipe in order to simplify query
CREATE OR REPLACE PROCEDURE insert_or_update_rating(
  rating_username VARCHAR(127),
  rated_recipe_name VARCHAR(511),
  rating_value SMALLINT
)
LANGUAGE plpgsql AS $$
BEGIN
  WITH "rating_user" AS (
    SELECT "id" FROM "users" WHERE "username" = rating_username
  ),
  "rated_recipe" AS (
    SELECT "id" FROM "recipes" WHERE "name" = rated_recipe_name
  )
  INSERT INTO "users_recipes_rating" ("user_id", "recipe_id", "rating")
  SELECT "rating_user"."id", "rated_recipe"."id", rating_value
  FROM "rating_user", "rated_recipe"
  ON CONFLICT ("user_id", "recipe_id") DO UPDATE
  SET "rating" = rating_value;
END $$;




-- creating view for ingredients used in recipes with basic nutrition information of each amount of ingredient used in a recipe
CREATE VIEW "recipe_ingredients_info" AS
SELECT
  "recipes"."id" AS "recipe_id",
  "recipes"."name" AS "recipe name",
  "ingredients"."name" AS "ingredient",
  "recipe_ingredients"."amount" AS "amount",
  "recipe_ingredients"."unit" AS "unit",
  "recipe_ingredients"."group" AS "group",
  ROUND("recipe_ingredients"."amount" * "ingredients"."kcal" / 100, 2) AS "kcal",
  ROUND("recipe_ingredients"."amount" * "ingredients"."carbohydrate" / 100, 2) AS "carbohydrate",
  ROUND("recipe_ingredients"."amount" * "ingredients"."protein" / 100, 2) AS "protein",
  ROUND("recipe_ingredients"."amount" * "ingredients"."fats" / 100, 2) AS "fats",
  ROUND("recipe_ingredients"."amount" * "ingredients"."fiber" / 100,2 ) AS "fiber"
FROM
  "recipes"
JOIN
  "recipe_ingredients" ON "recipes"."id" = "recipe_ingredients"."recipe_id"
JOIN
  "ingredients" ON "recipe_ingredients"."ingredient_id" = "ingredients"."id";


-- creating view for detail nutrition information of recipes
CREATE VIEW "recipe_nutritions_info" AS
SELECT
  "recipes"."id" AS "recipe_id",
  "recipes"."name" AS "recipe name",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."kcal" / 100), 2) AS "kcal",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."carbohydrate" / 100), 2) AS "carbohydrate",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."protein" / 100), 2) AS "protein",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."fats" / 100), 2) AS "fats",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."fiber" / 100), 2 ) AS "fiber",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."sugar" / 100), 2 ) AS "sugar",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."saturated_fatty_acids" / 100), 2 ) AS "saturated fatty acids",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."transfatty_acids" / 100), 2 ) AS "transfatty acids",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."monounsaturated_fats" / 100), 2 ) AS "monounsaturated fats",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."polyunsaturated_fats" / 100), 2 ) AS "polyunsaturated fats",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."cholesterol" / 100), 2 ) AS "cholesterol",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."salt" / 100), 2 ) AS "salt",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."water" / 100), 2 ) AS "water",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."calcium" / 100), 2 ) AS "calcium",
  ROUND(SUM("recipe_ingredients"."amount" * "ingredients"."PHE" / 100), 2 ) AS "PHE"
FROM
  "recipes"
JOIN
  "recipe_ingredients" ON "recipes"."id" = "recipe_ingredients"."recipe_id"
JOIN
  "ingredients" ON "recipe_ingredients"."ingredient_id" = "ingredients"."id"
GROUP BY "recipes"."id"
ORDER BY "recipe_id";


-- creating view for information (name, created by, average rating and basic nutrition information) on recipes
CREATE VIEW "recipes_info" AS
SELECT
  "recipes"."id",
  "recipes"."name" AS "recipe name",
  COALESCE("users"."username", 'unknown') AS "created by",
  COALESCE(ROUND(AVG("users_recipes_rating"."rating"), 2), 0) AS "rating",
  "recipe_nutritions_info"."kcal" AS "kcal",
  "recipe_nutritions_info"."carbohydrate" AS "carbohydrate",
  "recipe_nutritions_info"."protein" AS "protein",
  "recipe_nutritions_info"."fats" AS "fats",
  "recipe_nutritions_info"."fiber" AS "fiber"
FROM "recipes"
LEFT JOIN "users" ON "recipes"."created_by" = "users"."id"
LEFT JOIN "users_recipes_rating" ON "recipes"."id" = "users_recipes_rating"."recipe_id"
JOIN "recipe_nutritions_info" ON "recipes"."id" = "recipe_nutritions_info"."recipe_id"
GROUP BY "recipes"."id", "users"."username", "recipe_nutritions_info"."kcal", "recipe_nutritions_info"."carbohydrate", "recipe_nutritions_info"."protein", "recipe_nutritions_info"."fats", "recipe_nutritions_info"."fiber"
ORDER BY "recipes"."id";



