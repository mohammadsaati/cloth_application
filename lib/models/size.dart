class Size
{
    final String value;

    Size({ required this.value});

    static List<Size> fill({required  loadedSize})
    {
        List<Size> sizes = [];

        for(var size in loadedSize)
        {
            sizes.add(
                Size(value :size["value"])
            );
        }

        return sizes;
    }
}