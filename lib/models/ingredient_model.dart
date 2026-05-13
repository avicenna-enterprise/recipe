import 'package:flutter/material.dart';

class IngredientModel {
  final String name;
  final String quantity;
  final String emoji; // emoji as icon

  const IngredientModel({
    required this.name,
    required this.quantity,
    required this.emoji,
  });
}

// Ingredient data per recipe
class RecipeIngredients {
  static const Map<String, List<IngredientModel>> data = {
    '1': [ // Chicken Biryani
      IngredientModel(name: 'Chicken', quantity: '500g', emoji: '🍗'),
      IngredientModel(name: 'Basmati Rice', quantity: '2 cups', emoji: '🍚'),
      IngredientModel(name: 'Onion', quantity: '2 pcs', emoji: '🧅'),
      IngredientModel(name: 'Yogurt', quantity: '1 cup', emoji: '🥛'),
      IngredientModel(name: 'Tomatoes', quantity: '3 pcs', emoji: '🍅'),
      IngredientModel(name: 'Ginger', quantity: '1 inch', emoji: '🫚'),
      IngredientModel(name: 'Garlic', quantity: '5 cloves', emoji: '🧄'),
      IngredientModel(name: 'Biryani Spices', quantity: '2 tbsp', emoji: '🌶️'),
      IngredientModel(name: 'Saffron', quantity: 'pinch', emoji: '🌸'),
      IngredientModel(name: 'Ghee', quantity: '3 tbsp', emoji: '🧈'),
    ],
    '2': [ // Hotpot Special
      IngredientModel(name: 'Beef Slices', quantity: '300g', emoji: '🥩'),
      IngredientModel(name: 'Mushrooms', quantity: '200g', emoji: '🍄'),
      IngredientModel(name: 'Tofu', quantity: '150g', emoji: '🟨'),
      IngredientModel(name: 'Cabbage', quantity: '300g', emoji: '🥬'),
      IngredientModel(name: 'Noodles', quantity: '200g', emoji: '🍜'),
      IngredientModel(name: 'Broth', quantity: '1L', emoji: '🍲'),
      IngredientModel(name: 'Chili Oil', quantity: '2 tbsp', emoji: '🌶️'),
      IngredientModel(name: 'Spring Onion', quantity: '4 pcs', emoji: '🌿'),
    ],
    '3': [ // Polina Special
      IngredientModel(name: 'Pasta', quantity: '200g', emoji: '🍝'),
      IngredientModel(name: 'Cream', quantity: '100ml', emoji: '🥛'),
      IngredientModel(name: 'Parmesan', quantity: '50g', emoji: '🧀'),
      IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),
      IngredientModel(name: 'Olive Oil', quantity: '2 tbsp', emoji: '🫒'),
      IngredientModel(name: 'Basil', quantity: 'handful', emoji: '🌿'),
    ],
    '5': [ // Grilled Chicken
      IngredientModel(name: 'Chicken Breast', quantity: '400g', emoji: '🍗'),
      IngredientModel(name: 'Lemon', quantity: '2 pcs', emoji: '🍋'),
      IngredientModel(name: 'Garlic', quantity: '4 cloves', emoji: '🧄'),
      IngredientModel(name: 'Olive Oil', quantity: '3 tbsp', emoji: '🫒'),
      IngredientModel(name: 'Rosemary', quantity: '2 sprigs', emoji: '🌿'),
      IngredientModel(name: 'Black Pepper', quantity: '1 tsp', emoji: '🫙'),
      IngredientModel(name: 'Salt', quantity: 'to taste', emoji: '🧂'),
    ],
    '6': [ // Italian Food
      IngredientModel(name: 'Spaghetti', quantity: '200g', emoji: '🍝'),
      IngredientModel(name: 'Tomato Sauce', quantity: '300ml', emoji: '🍅'),
      IngredientModel(name: 'Ground Beef', quantity: '250g', emoji: '🥩'),
      IngredientModel(name: 'Onion', quantity: '1 pc', emoji: '🧅'),
      IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),
      IngredientModel(name: 'Parmesan', quantity: '50g', emoji: '🧀'),
      IngredientModel(name: 'Basil', quantity: 'handful', emoji: '🌿'),
      IngredientModel(name: 'Olive Oil', quantity: '2 tbsp', emoji: '🫒'),
    ],
    '9': [ // Crunchy Nut Coleslaw
      IngredientModel(name: 'Cabbage', quantity: '300g', emoji: '🥬'),
      IngredientModel(name: 'Carrots', quantity: '2 pcs', emoji: '🥕'),
      IngredientModel(name: 'Walnuts', quantity: '100g', emoji: '🌰'),
      IngredientModel(name: 'Mayonnaise', quantity: '4 tbsp', emoji: '🥄'),
      IngredientModel(name: 'Lemon Juice', quantity: '2 tbsp', emoji: '🍋'),
      IngredientModel(name: 'Sugar', quantity: '1 tsp', emoji: '🍬'),
      IngredientModel(name: 'Salt', quantity: 'to taste', emoji: '🧂'),
    ],
    '10': [ // Classic Greek Salad
      IngredientModel(name: 'Tomatoes', quantity: '500g', emoji: '🍅'),
      IngredientModel(name: 'Cucumber', quantity: '1 pc', emoji: '🥒'),
      IngredientModel(name: 'Feta Cheese', quantity: '200g', emoji: '🧀'),
      IngredientModel(name: 'Olives', quantity: '100g', emoji: '🫒'),
      IngredientModel(name: 'Red Onion', quantity: '1 pc', emoji: '🧅'),
      IngredientModel(name: 'Olive Oil', quantity: '3 tbsp', emoji: '🫒'),
      IngredientModel(name: 'Oregano', quantity: '1 tsp', emoji: '🌿'),
    ],
    '13': [ // Traditional Spare Ribs
      IngredientModel(name: 'Spare Ribs', quantity: '1 kg', emoji: '🍖'),
      IngredientModel(name: 'BBQ Sauce', quantity: '200ml', emoji: '🫙'),
      IngredientModel(name: 'Garlic', quantity: '5 cloves', emoji: '🧄'),
      IngredientModel(name: 'Honey', quantity: '3 tbsp', emoji: '🍯'),
      IngredientModel(name: 'Soy Sauce', quantity: '4 tbsp', emoji: '🫙'),
      IngredientModel(name: 'Ginger', quantity: '1 inch', emoji: '🫚'),
      IngredientModel(name: 'Black Pepper', quantity: '1 tsp', emoji: '🫙'),
    ],
    '14': [ // Lamb Chops
      IngredientModel(name: 'Lamb Chops', quantity: '600g', emoji: '🍖'),
      IngredientModel(name: 'Couscous', quantity: '200g', emoji: '🍚'),
      IngredientModel(name: 'Dried Fruits', quantity: '100g', emoji: '🍇'),
      IngredientModel(name: 'Mint', quantity: 'handful', emoji: '🌿'),
      IngredientModel(name: 'Lemon', quantity: '1 pc', emoji: '🍋'),
      IngredientModel(name: 'Olive Oil', quantity: '3 tbsp', emoji: '🫒'),
      IngredientModel(name: 'Cumin', quantity: '1 tsp', emoji: '🌶️'),
    ],
    '15': [ // Chinese Egg Fried Rice
      IngredientModel(name: 'Rice', quantity: '2 cups', emoji: '🍚'),
      IngredientModel(name: 'Eggs', quantity: '3 pcs', emoji: '🥚'),
      IngredientModel(name: 'Spring Onion', quantity: '4 pcs', emoji: '🌿'),
      IngredientModel(name: 'Soy Sauce', quantity: '3 tbsp', emoji: '🫙'),
      IngredientModel(name: 'Sesame Oil', quantity: '1 tbsp', emoji: '🫒'),
      IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),
      IngredientModel(name: 'Peas', quantity: '100g', emoji: '🫛'),
      IngredientModel(name: 'Carrots', quantity: '1 pc', emoji: '🥕'),
    ],
  };

  static List<IngredientModel> getFor(String recipeId) {
    return data[recipeId] ?? [
      IngredientModel(name: 'Ingredient 1', quantity: '100g', emoji: '🥘'),
      IngredientModel(name: 'Ingredient 2', quantity: '200g', emoji: '🍳'),
      IngredientModel(name: 'Ingredient 3', quantity: '50g', emoji: '🧂'),
    ];
  }
}
