
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
    '11': [ // Spice Roasted Chicken
      IngredientModel(name: 'Chicken', quantity: '500g', emoji: '🍗'),
      IngredientModel(name: 'Olive Oil', quantity: '2 tbsp', emoji: '🧴'),
      IngredientModel(name: 'Garlic', quantity: '4 cloves', emoji: '🧄'),
      IngredientModel(name: 'Paprika', quantity: '1 tsp', emoji: '🌶️'),
      IngredientModel(name: 'Cumin', quantity: '1 tsp', emoji: '🌱'),
      IngredientModel(name: 'Salt', quantity: 'to taste', emoji: '🧂'),
      IngredientModel(name: 'Black Pepper', quantity: '1/2 tsp', emoji: '🫙'),
    ],
    '12': [ // Steak with Tomato
      IngredientModel(name: 'Beef Steak', quantity: '400g', emoji: '🥩'),
      IngredientModel(name: 'Tomatoes', quantity: '3 pcs', emoji: '🍅'),
      IngredientModel(name: 'Butter', quantity: '2 tbsp', emoji: '🧈'),
      IngredientModel(name: 'Garlic', quantity: '2 cloves', emoji: '🧄'),
      IngredientModel(name: 'Rosemary', quantity: '1 sprig', emoji: '🌿'),
      IngredientModel(name: 'Salt', quantity: 'to taste', emoji: '🧂'),
      IngredientModel(name: 'Olive Oil', quantity: '1 tbsp', emoji: '🧴'),
    ],
  };

  static String getEmoji(String name) {
    final n = name.toLowerCase();
    if (n.contains('chicken') || n.contains('meat') || n.contains('leg') || n.contains('wing')) return '🍗';
    if (n.contains('rice')) return '🍚';
    if (n.contains('oil')) return '🫒';
    if (n.contains('salt')) return '🧂';
    if (n.contains('sugar')) return '🍬';
    if (n.contains('pepper')) return '🫙';
    if (n.contains('tomato')) return '🍅';
    if (n.contains('onion')) return '🧅';
    if (n.contains('garlic')) return '🧄';
    if (n.contains('egg')) return '🥚';
    if (n.contains('milk') || n.contains('yogurt')) return '🥛';
    if (n.contains('beef') || n.contains('meat')) return '🥩';
    if (n.contains('water')) return '💧';
    if (n.contains('flour')) return '🌾';
    if (n.contains('butter') || n.contains('ghee')) return '🧈';
    if (n.contains('chili') || n.contains('spice')) return '🌶️';
    if (n.contains('pasta') || n.contains('noodle')) return '🍝';
    return '🍳'; // Default
  }

  static List<IngredientModel> getSuggestions(String recipeName) {
    final name = recipeName.toLowerCase();
    if (name.contains('biryani')) return data['1']!;
    if (name.contains('hotpot')) return data['2']!;
    if (name.contains('pasta') || name.contains('polina')) return data['3']!;
    if (name.contains('grilled') || name.contains('chicken')) return data['5']!;
    if (name.contains('spaghetti') || name.contains('italian')) return data['6']!;
    if (name.contains('coleslaw') || name.contains('salad')) return data['9']!;
    if (name.contains('greek')) return data['10']!;
    if (name.contains('ribs')) return data['13']!;
    if (name.contains('lamb')) return data['14']!;
    if (name.contains('fried rice') || name.contains('chinese')) return data['15']!;

    return []; // No suggestions found
  }

  static List<IngredientModel> getFor(String recipeId) {
    return data[recipeId] ?? [
      IngredientModel(name: 'Ingredient 1', quantity: '100g', emoji: '🥘'),
      IngredientModel(name: 'Ingredient 2', quantity: '200g', emoji: '🍳'),
      IngredientModel(name: 'Ingredient 3', quantity: '50g', emoji: '🧂'),
    ];
  }
}
