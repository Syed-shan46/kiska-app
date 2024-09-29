
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    
    categories.add(CategoryModel(name: 'Earbud',
        iconPath: 'assets/icons/categories/earbud.png',
        boxColor: Colors.blue.withOpacity(0.8),));

    categories.add(CategoryModel(name: 'Keyboard',
        iconPath: 'assets/icons/categories/keyboard.png',
        boxColor: Colors.green.withOpacity(0.8),));

    categories.add(CategoryModel(name: 'Sneakers',
        iconPath: 'assets/icons/categories/sneakers.png',
        boxColor: Colors.purple.withOpacity(0.8)));

    categories.add(CategoryModel(name: 'Watch',
      iconPath: 'assets/icons/categories/watch.png',
      boxColor: Colors.lightBlueAccent.withOpacity(0.8),));

    categories.add(CategoryModel(name: 'Laptop',
        iconPath: 'assets/icons/categories/laptop.png',
        boxColor: Colors.deepOrangeAccent.withOpacity(0.8)));

    categories.add(CategoryModel(name: 'Mouse',
        iconPath: 'assets/icons/categories/mouse.png',
        boxColor: Colors.orangeAccent.withOpacity(0.8),));



    categories.add(CategoryModel(name: 'Furniture',
        iconPath: 'assets/icons/categories/furniture.png',
        boxColor: Colors.red.withOpacity(0.8)));
    return categories;
  }
}