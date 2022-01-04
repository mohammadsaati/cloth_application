class Category
{
    final int  id;
    final String  slug;
    final String name;

    Category({ required this.id , required this.slug , required this.name });

    static List<Category> fillCategories(loadedCategory)
    {
        List<Category> categories = [];

        for(var category in loadedCategory)
        {
            categories.add(

                Category(
                  id: category["id"],
                  slug: category["slug"],
                  name: category["name"]
              )

            );
        }

        return categories;
    }
}
