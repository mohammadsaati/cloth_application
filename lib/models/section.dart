import 'package:cloth_app/models/products.dart';

class Section
{
    final String title;
    final String slug;
    final List<Product> product;

    Section(this.title , this.slug , this.product);
}
