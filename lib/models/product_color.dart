class ProductColor
{
    final int id;
    final String name;
    final String code;

    ProductColor({ required this.id , required this.name , required this.code});

    static List<ProductColor> fill({required  loadedColors})
    {
        List<ProductColor> colors = [];

        for(var color in loadedColors)
        {
            colors.add(
                ProductColor(
                    id: color["id"],
                    name: color["name"],
                    code: color["code"] ?? "#000"
                )
            );
        }

        return colors;
    }
}