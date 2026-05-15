import 'package:flutter/material.dart';

class IngredientModel {
  final String name;
  final String quantity;
  final String emoji;
  final String? image;

  const IngredientModel({
    required this.name,
    required this.quantity,
    required this.emoji,
    this.image,
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
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),

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
      IngredientModel(name: 'Chili Oil', quantity: '2 tbsp', emoji: '🧴'),
      IngredientModel(name: 'Spring Onion', quantity: '4 pcs', emoji: '🌿'),
    ],
    '3': [ // Polina Special
      IngredientModel(name: 'chicken', quantity: '200g', emoji: '🍗'),
      IngredientModel(name: 'Cream', quantity: '100ml', emoji: '🥛'),
      IngredientModel(name: 'Parmesan', quantity: '50g', emoji: '🧀'),
      IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),

      IngredientModel(name: 'Basil', quantity: 'handful', emoji: '🌿'),
    ],
    '5': [ // Grilled Chicken
      IngredientModel(name: 'Chicken Breast', quantity: '400g', emoji: '🍗'),
      IngredientModel(name: 'Lemon', quantity: '2 pcs', emoji: '🍋'),
      IngredientModel(name: 'Garlic', quantity: '4 cloves', emoji: '🧄'),
      IngredientModel(name: 'Rosemary', quantity: '2 sprigs', emoji: '🌿'),
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
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
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),

    ],
    '9': [ // Crunchy Nut Coleslaw
      IngredientModel(name: 'Cabbage', quantity: '300g', emoji: '🥬'),
      IngredientModel(name: 'Carrots', quantity: '2 pcs', emoji: '🥕'),
      IngredientModel(name: 'Walnuts', quantity: '100g', emoji: '🌰'),
      IngredientModel(name: 'Mayonnaise', quantity: '4 tbsp', emoji: '🍯'),
      IngredientModel(name: 'Lemon Juice', quantity: '2 tbsp', emoji: '🍋'),
      IngredientModel(name: 'Sugar', quantity: '1 tsp', emoji: '🍬'),
      IngredientModel(name: 'Salt', quantity: 'to taste', emoji: '🧂'),
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
    ],
    '10': [ // Classic Greek Salad
      IngredientModel(name: 'Tomatoes', quantity: '500g', emoji: '🍅'),
      IngredientModel(name: 'Cucumber', quantity: '1 pc', emoji: '🥒'),
      IngredientModel(name: 'Feta Cheese', quantity: '200g', emoji: '🧀'),
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
      IngredientModel(name: 'Red Onion', quantity: '1 pc', emoji: '🧅'),

      IngredientModel(name: 'Oregano', quantity: '1 tsp', emoji: '🌿'),
    ],
    '13': [ // Traditional Spare Ribs
  IngredientModel(name: 'Spare Ribs', quantity: '1 kg', emoji: '🍖'),
      IngredientModel(name: 'BBQ Sauce', quantity: '200ml', emoji: '🍯'),
  IngredientModel(name: 'Garlic', quantity: '5 cloves', emoji: '🧄'),
  IngredientModel(name: 'Honey', quantity: '3 tbsp', emoji: '🍯'),
      IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),

  ],
  '14': [ // Lamb Chops
  IngredientModel(name: 'Lamb Chops', quantity: '600g', emoji: '🍖'),
  IngredientModel(name: 'Couscous', quantity: '200g', emoji: '🍚'),
  IngredientModel(name: 'Dried Fruits', quantity: '100g', emoji: '🍇'),
  IngredientModel(name: 'Mint', quantity: 'handful', emoji: '🌿'),
  IngredientModel(name: 'Lemon', quantity: '1 pc', emoji: '🍋'),
    IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),

  IngredientModel(name: 'Cumin', quantity: '1 tsp', emoji: '🌱'),
  ],
  '15': [ // Chinese Egg Fried Rice
  IngredientModel(name: 'Rice', quantity: '2 cups', emoji: '🍚'),
  IngredientModel(name: 'Eggs', quantity: '3 pcs', emoji: '🥚'),
  IngredientModel(name: 'Spring Onion', quantity: '4 pcs', emoji: '🌿'),
    IngredientModel(name: ' Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
  IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),

  IngredientModel(name: 'Carrots', quantity: '1 pc', emoji: '🥕'),
  ],
};

  static String getEmoji(String name) {
    final n = name.toLowerCase();
    if (n.contains('chicken')) return '🍗';
    if (n.contains('beef') || n.contains('meat') || n.contains('lamb') || n.contains('steak')) return '🥩';
    if (n.contains('rice') || n.contains('pulao')) return '🍚';
    if (n.contains('onion')) return '🧅';
    if (n.contains('tomato') || n.contains('ketchup') || n.contains('sauce')) return '🍅';
    if (n.contains('garlic')) return '🧄';
    if (n.contains('egg')) return '🥚';
    if (n.contains('milk') || n.contains('cream') || n.contains('yogurt') || n.contains('butter')) return '🥛';
    if (n.contains('cheese') || n.contains('parmesan')) return '🧀';
    if (n.contains('oil')) return '🧴';
    if (n.contains('spice') || n.contains('chili') || n.contains('pepper') || n.contains('ginger')) return '🌶️';
    if (n.contains('salt') || n.contains('powder') || n.contains('flour')) return '🧂';
    if (n.contains('sugar') || n.contains('sweet') || n.contains('honey') || n.contains('syrup')) return '🍯';
    if (n.contains('lemon') || n.contains('lime')) return '🍋';
    if (n.contains('mushroom')) return '🍄';
    if (n.contains('tofu') || n.contains('paneer')) return '🟨';
    if (n.contains('noodle') || n.contains('pasta') || n.contains('spaghetti') || n.contains('chow mein')) return '🍝';
    if (n.contains('broth') || n.contains('soup')) return '🍲';
    if (n.contains('carrot')) return '🥕';
    if (n.contains('cucumber')) return '🥒';
    if (n.contains('nut') || n.contains('walnut') || n.contains('almond')) return '🌰';
    if (n.contains('ribs') || n.contains('chops')) return '🍖';
    if (n.contains('bread') || n.contains('bun') || n.contains('roti')) return '🍞';
    if (n.contains('fish') || n.contains('seafood') || n.contains('shrimp')) return '🐟';
    if (n.contains('fruit') || n.contains('apple') || n.contains('mango')) return '🍎';
    if (n.contains('basil') || n.contains('mint') || n.contains('herb') || n.contains('rosemary') || n.contains('spring onion') || n.contains('cabbage') || n.contains('lettuce') || n.contains('green')) return '🌿';
    return '🍴';
  }

  static List<IngredientModel> getSuggestions(String recipeName) {
    final n = recipeName.toLowerCase();
    if (n.contains('chicken')) {
      return [
        IngredientModel(name: 'Chicken', quantity: '500g', emoji: '🍗'),
        IngredientModel(name: 'Garlic', quantity: '3 cloves', emoji: '🧄'),
        IngredientModel(name: 'Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
      ];
    }
    if (n.contains('biryani') || n.contains('rice')) {
      return [
        IngredientModel(name: 'Rice', quantity: '2 cups', emoji: '🍚'),
        IngredientModel(name: 'Onion', quantity: '2 pcs', emoji: '🧅'),
        IngredientModel(name: 'Spices', quantity: '2 tbsp', emoji: '🌶️'),
      ];
    }
    if (n.contains('pasta') || n.contains('spaghetti')) {
      return [
        IngredientModel(name: 'Pasta', quantity: '200g', emoji: '🍝'),
        IngredientModel(name: 'Tomato Sauce', quantity: '300ml', emoji: '🍅'),
        IngredientModel(name: 'Parmesan', quantity: '50g', emoji: '🧀'),
      ];
    }
    if (n.contains('salad')) {
      return [
        IngredientModel(name: 'Tomatoes', quantity: '2 pcs', emoji: '🍅'),
        IngredientModel(name: 'Cucumber', quantity: '1 pc', emoji: '🥒'),
        IngredientModel(name: 'Lettuce', quantity: '1 head', emoji: '🌿'),
      ];
    }
    return [];
  }

static List<IngredientModel> getFor(String recipeId) {
return data[recipeId] ?? [
IngredientModel(name: 'Ingredient 1', quantity: '100g', emoji: '🥘'),
IngredientModel(name: 'Ingredient 2', quantity: '200g', emoji: '🍳'),
IngredientModel(name: 'Ingredient 3', quantity: '50g', emoji: '🧂'),
];
}
}
