class CategoryItem {
  final int id;
  final String title, icon;
  

  CategoryItem({
     this.id,
     this.icon,
     this.title,
   
  });
}

// Our demo Category

List<CategoryItem> category = [
  CategoryItem(
    id: 1,
    icon: "assets/images/food.png",
    title: "Food",
  ),
  CategoryItem(
    id: 2,
    icon: "assets/images/drink.png",
    title: "Drink",
  ),
  CategoryItem(
    id: 3,
    icon: "assets/images/dessert.png",
    title: "Dessert",
  ),
];
