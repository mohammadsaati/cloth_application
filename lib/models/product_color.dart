class ProductColor
{
    final String name;
    final String code;

    ProductColor({ required this.name , required this.code});

    static List<ProductColor> fill({required  loadedColors})
    {
        List<ProductColor> colors = [];

        for(var color in loadedColors)
        {
            colors.add(
                ProductColor(name: color["name"], code: color["code"])
            );
        }

        return colors;
    }
}