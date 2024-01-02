-- sample data used only for functionality testing
INSERT INTO "users" ("first_name", "last_name", "username", "password")
VALUES
  ('John', 'Doe', 'johndoe', 'password123'),
  ('Jane', 'Smith', 'janesmith', 'securepassword'),
  ('Alice', 'Johnson', 'alicej', 'strongpassword'),
  ('Bob', 'Williams', 'bobby', 'pass123'),
  ('Eva', 'Miller', 'evam', 'myp@ssword');

INSERT INTO "ingredients" (
  "name", "kcal", "protein", "protein_unit", "carbohydrate", "carbohydrate_unit",
  "sugar", "sugar_unit", "fats", "fats_unit", "saturated_fatty_acids", "saturated_fatty_acids_unit",
  "transfatty_acids", "transfatty_acids_unit", "monounsaturated_fats", "monounsaturated_fats_unit",
  "polyunsaturated_fats", "polyunsaturated_fats_unit", "cholesterol", "cholesterol_unit",
  "fiber", "fiber_unit", "salt", "salt_unit", "water", "water_unit",
  "calcium", "calcium_unit", "PHE", "PHE_unit"
)
VALUES
    ('Spaghetti', 131, 5, 'g', 25.4, 'g', 1, 'g', 0.5, 'g', 0.1, 'g', 0, 'g', 0.1, 'g', 0.2, 'g', 0.8, 'g', 0, 'g', 2.5, 'g', 0.3, 'g', 12, 'mg', 0, 'mg'),
    ('Butter', 717, 0.6, 'g', 0, 'g', 0, 'g', 81.5, 'g', 51.4, 'g', 0, 'g', 0, 'g', 3.7, 'g', 2.3, 'g', 0, 'g', 0.9, 'g', 15.8, 'g', 24, 'mg', 0, 'mg'),
    ('Black Pepper', 251, 10.4, 'g', 49.1, 'g', 0.6, 'g', 3.3, 'g', 1.7, 'g', 0, 'g', 0, 'g', 1.3, 'g', 3.6, 'g', 0, 'g', 25.8, 'g', 10.4, 'g', 10.6, 'g', 443, 'mg'),
    ('Parmesan', 431, 38.5, 'g', 4.1, 'g', 0, 'g', 29.3, 'g', 19, 'g', 12.4, 'g', 0, 'g', 7.9, 'g', 2.4, 'g', 67, 'mg', 0, 'g', 0, 'g', 28, 'g', 1184, 'mg'),
    ('Canned Cherry Tomatoes', 32, 1, 'g', 6.9, 'g', 4.2, 'g', 0.3, 'g', 0, 'g', 0, 'g', 0, 'g', 0.1, 'g', 0.1, 'g', 0, 'g', 2.5, 'g', 0.6, 'g', 95.5, 'g', 11, 'mg'),
    ('Canned Mixed Bean Salad', 73, 3.3, 'g', 11.9, 'g', 1.2, 'g', 1.2, 'g', 0.2, 'g', 0, 'g', 0, 'g', 0.2, 'g', 0.8, 'g', 0, 'g', 4.8, 'g', 1.2, 'g', 82, 'g', 28, 'mg'),
    ('Baby Spinach', 23, 2.9, 'g', 0.4, 'g', 0.4, 'g', 0.4, 'g', 0.1, 'g', 0, 'g', 0, 'g', 0.1, 'g', 0.4, 'g', 0, 'g', 2.2, 'g', 0.6, 'g', 91.4, 'g', 99, 'mg'),
    ('Medium Eggs', 143, 12.6, 'g', 0.6, 'g', 0.6, 'g', 9.9, 'g', 3.3, 'g', 0, 'g', 0, 'g', 3.3, 'g', 1.7, 'g', 373, 'mg', 0, 'g', 0, 'g', 75.6, 'g', 56, 'mg'),
    ('Smoked Ham', 107, 18, 'g', 1, 'g', 1, 'g', 3.4, 'g', 1.2, 'g', 0.2, 'g', 0, 'g', 1.3, 'g', 0.5, 'g', 37, 'mg', 0, 'g', 0, 'g', 75.4, 'g', 11, 'mg'),
    ('Rye Bread', 258, 8, 'g', 42.9, 'g', 1.4, 'g', 3.6, 'g', 0.5, 'g', 0.1, 'g', 0, 'g', 0.6, 'g', 0.7, 'g', 0, 'g', 7.6, 'g', 2.2, 'g', 35.6, 'g', 37, 'mg'),
    ('Gnocchi', 154, 3, 'g', 31, 'g', 0, 'g', 1, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 1, 'g', 0, 'g', 0, 'g', 0, 'mg'),
    ('Salad Leaves', 5, 0.5, 'g', 1, 'g', 0.3, 'g', 0.1, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0.6, 'g', 0.2, 'g', 0.3, 'g', 0, 'mg'),
    ('Rapeseed Oil', 884, 0, 'g', 0, 'g', 0, 'g',  100, 'g', 6.7, 'g', 0.5, 'g', 60, 'g', 31, 'g', 28, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'mg'),
    ('Red Onion', 40, 1.1, 'g', 9.3, 'g', 4.7, 'g', 0.1, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0.5, 'g', 0.02, 'g', 0.02, 'g', 0, 'mg'),
    ('Kale', 35, 2.2, 'g', 6.7, 'g', 1.3, 'g', 0.5, 'g', 0.1, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0.02, 'g', 0.01, 'g', 0, 'mg'),
    ('Wholemeal Penne', 180, 7.7, 'g', 35.6, 'g', 1.4, 'g', 1.9, 'g', 0.4, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 5, 'g', 0, 'g', 0, 'mg'),
    ('Reduced-Fat Soft Cheese', 229, 8.3, 'g', 3.9, 'g', 3.8, 'g', 19, 'g', 11.9, 'g', 0.8, 'g', 0, 'g', 0, 'g', 0, 'g', 57, 'mg', 0, 'g', 0, 'g', 0, 'g', 0, 'mg'),
    ('Jar Pesto', 303, 2, 'g', 3, 'g', 0, 'g', 31, 'g', 4.5, 'g', 0.5, 'g', 0, 'g', 0, 'g', 0, 'g', 11, 'mg', 2.3, 'g', 1.1, 'g', 0.3, 'g', 0, 'mg'),
    ('Wholemeal Noodles', 211, 10.6, 'g', 42.9, 'g', 1.4, 'g', 1.6, 'g', 0.3, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 4, 'g', 0, 'g', 0, 'mg'),
    ('Sesame Seeds', 573, 17, 'g', 23, 'g', 0.3, 'g', 50, 'g', 7, 'g', 0, 'g', 25, 'g', 19, 'g', 23, 'g', 0, 'mg', 12, 'g', 6.7, 'g', 4.7, 'g', 0, 'mg'),
    ('Soy Sauce', 53, 5.5, 'g', 1.6, 'g', 0.6, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'mg', 0.1, 'g', 5.5, 'g', 92, 'g', 0, 'mg'),
    ('Rice Vinegar', 18, 0.1, 'g', 0.9, 'g', 0.9, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'g', 0, 'mg', 0, 'g', 0.1, 'g', 97, 'g', 0, 'mg'),
    ('Seabass Fillet', 97, 20.7, 'g', 0, 'g', 0, 'g', 1.8, 'g', 0.5, 'g', 0, 'g', 0, 'g', 0.5, 'g', 0.5, 'g', 51, 'mg', 0, 'g', 0, 'g', 80, 'g', 0, 'mg');


INSERT INTO "recipes" ("name", "url", "photo", "created_by")
VALUES
    ('White fish with sesame noodles', 'https://www.bbcgoodfood.com/recipes/white-fish-sesame-noodles', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/white-fish-with-sesame-noodles-90a7e31.jpg?quality=90&webp=true&resize=440,400', NULL),
    ('Saucy Bean Baked Eggs', 'https://www.bbcgoodfood.com/recipes/saucy-bean-baked-eggs', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/saucy-bean-baked-eggs-d582e18.jpg?quality=90&webp=true&resize=440,400', NULL),
    ('Gnocchi cacio e pepe', 'https://www.bbcgoodfood.com/recipes/gnocchi-cacio-e-pepe', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/gnocchi-cacio-e-pepe-a1392fd.jpg?quality=90&webp=true&resize=440,400', 1),
    ('Creamy Pesto & Kale Pasta', 'https://www.bbcgoodfood.com/recipes/creamy-pesto-kale-pasta', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/creamy-pesto-kale-pasta-d582e18.jpg?quality=90&webp=true&resize=440,400', 1),
    ('Cacio e pepe', 'https://www.bbcgoodfood.com/recipes/cacio-e-pepe', 'https://images.immediate.co.uk/production/volatile/sites/30/2021/03/Cacio-e-Pepe-e44b9f8.jpg?quality=90&webp=true&resize=375,341', 3);


INSERT INTO "instructions" ("recipe_id", "step", "instruction", "photo")
VALUES
    (1, 1, 'Use a spice grinder or pestle and mortar to crush the sesame seeds, then stir in the soy sauce, oil, 1 tbsp of water and a splash of rice vinegar, to make a creamy dressing, season and set aside.', NULL),
    (1, 2, 'Bring a pan of salted water to the boil, add the noodles and cook following pack instructions, then drain and set aside. Using the same pan, tip in all the spinach and cook until reduced down and dark green. Tip in the noodles, along with the sesame dressing and a splash of water and toss well to heat through.', NULL),
    (1, 3, 'Heat the oil in a non-stick frying pan over a medium to high heat. Season the skin of the seabass, then place in the pan skin-side down, fry until the skin has crisped up and the flesh has nearly all turned opaque, around 3 mins. Flip over and fry for 30 seconds further, until the fish is flaking and cooked through. Divide the noodles and greens between two bowls and place the fish on top. Scatter over the toasted sesame seeds and serve.', NULL),
    (2, 1, 'Tip the tomatoes and bean salad into an ovenproof frying pan or shallow flameproof casserole dish. Simmer for 10 mins, or until reduced. Stir in the spinach and cook for 5 mins more until wilted.', NULL),
    (2, 2, 'Heat the grill to medium. Make four indentations in the mixture using the back of a spoon, then crack one egg in each. Nestle the ham in the mixture, then grill for 4-5 mins, or until the whites are set and the yolks runny. Serve with rye bread, if you like.', NULL),
    (3, 1, 'Cook the gnocchi in a large pan of lightly salted, boiling water. Drain and reserve 200ml of the cooking water.', NULL),
    (3, 2, 'Heat the butter in a large frying pan. Add the gnocchi, cheese and pepper as well as 150ml of the cooking water, raise the heat a little and stir vigorously until melted and the gnocchi is well coated. Pour in more of the reserved water if you like it saucier. Season with a little salt. Transfer the gnocchi to bowls and serve with a mixed salad, if you like.', NULL),
    (4, 1, 'Heat the oil in a large pan over a medium heat. Fry the onions for 10 mins until softened and beginning to caramelise. Add the kale and 100ml water, then cover and cook for 5 mins more, or until the kale has wilted.', NULL),
    (4, 2, 'Cook the pasta following pack instructions. Drain, reserving a little of the cooking water. Toss the pasta with the onion mixture, soft cheese and pesto, adding a splash of the reserved cooking water to loosen, if needed. Season.', NULL),
    (5, 1, 'Cook the pasta for 2 mins less than pack instructions state, in salted boiling water. Meanwhile, melt the butter in a medium frying pan over a low heat, then add the ground black pepper and toast for a few minutes.', NULL),
    (5, 2, 'Drain the pasta, keeping 200ml of the pasta water. Tip the pasta and 100ml of the pasta water into the pan with the butter and pepper. Toss briefly, then scatter over the parmesan evenly, but don’t stir – wait for the cheese to melt for 30 seconds, then once melted, toss everything well, and stir together. This prevents the cheese from clumping or going stringy and makes a smooth, shiny sauce. Add a splash more pasta water if you need to, to loosen the sauce and coat the pasta. Serve immediately with a good grating of black pepper.', NULL);

INSERT INTO "recipe_ingredients" ("recipe_id", "group", "ingredient_id", "amount", "unit")
VALUES
    (1, NULL, 19, 150, 'g'),         -- wholemeal noodles
    (1, NULL, 20, 25, 'g'),          -- sesame seeds
    (1, NULL, 21, 20, 'g'),          -- soy sauce
    (1, NULL, 13, 15, 'g'),          -- oil
    (1, NULL, 22, 12, 'g'),          -- rice vinegar
    (1, NULL, 7, 200, 'g'),          -- spinach leaves
    (1, NULL, 23, 200, 'g'),         -- seabass fillets
    (2, NULL, 5, 800, 'g'),          -- cherry tomatoes
    (2, NULL, 6, 400, 'g'),          -- mixed bean salad
    (2, NULL, 7, 200, 'g'),          -- baby spinach
    (2, NULL, 8, 200, 'g'),          -- medium eggs
    (2, NULL, 9, 50, 'g'),           -- smoked ham
    (3, NULL, 11, 300, 'g'),         -- gnocchi
    (3, NULL, 2, 35, 'g'),           -- butter
    (3, NULL, 4, 60, 'g'),           -- parmesan
    (3, NULL, 3, 5, 'g'),            -- pepper
    (4, NULL, 13, 16, 'g'),          -- rapeseed oil
    (4, NULL, 14, 140, 'g'),         -- red onions
    (4, NULL, 15, 300, 'g'),         -- kale
    (4, NULL, 16, 300, 'g'),         -- wholemeal pasta
    (4, NULL, 17, 60, 'g'),          -- reduced-fat soft cheese
    (4, NULL, 18, 60, 'g'),          -- jar pesto
    (5, NULL, 1, 200, 'g'),          -- spaghetti
    (5, NULL, 2, 25, 'g'),           -- butter
    (5, NULL, 3, 5, 'g'),            -- black pepper
    (5, NULL, 4, 50, 'g');           -- parmesan

INSERT INTO "tags" ("recipe_id", "tag")
VALUES
    (1, 'dinner'),
    (3, 'dinner'),
    (4, 'dinner'),
    (1, 'fish'),
    (2, 'lunch'),
    (5, 'lunch'),
    (1, 'pasta'),
    (3, 'pasta'),
    (4, 'pasta'),
    (5, 'pasta');


INSERT INTO "users_recipes_rating" ("user_id", "recipe_id", "rating")
VALUES
    (1, 1, 9),
    (1, 4, -10),
    (1, 5, 2),
    (1, 2, 8),
    (1, 3, -3),
    (2, 3, 6),
    (2, 5, 1),
    (3, 2, 8),
    (3, 4, 7),
    (3, 1, 10),
    (4, 4, 4);
