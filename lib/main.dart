import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

///////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping app',
      home: ShoppingList(
        products: <Product>[
          Product(name: 'eggs'),
          Product(name: 'apple'),
          Product(name: 'pizza'),
          Product(name: 'sandwich'),
          Product(name: 'hat'),
          Product(name: 'shirt'),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////

class Product {
  final String name;
  Product({this.name});
}

typedef void CartChangedCallback(Product product, bool inCart);

///////////////////////////////////////////////////////////////

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  ShoppingList({this.products, Product product});

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> shoppingCart = Set<Product>();

  void handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        shoppingCart.remove(product);
      } else {
        shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Your Name",style: TextStyle(fontSize: 15),),
              accountEmail: Text("Your Number/E-mail",style: TextStyle(fontSize: 10),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("E",style: TextStyle(fontSize: 15),),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue,
                  Colors.pink,
                ])
              ),
            ),
            ListTile(
              title: Text("profile"),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text("new cart"),
              leading: Icon(Icons.fiber_new),
            ),
            ListTile(
              title: Text("setting"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("Log out"),
              leading: Icon(Icons.power_settings_new),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: shoppingCart.contains(product),
            onCartChanged: handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final CartChangedCallback onCartChanged;
  final bool inCart;
  ShoppingListItem({this.product, this.onCartChanged, this.inCart});

  Color getColor(BuildContext context) {
    return inCart ? Colors.grey : Theme.of(context).primaryColor;
  }

  TextStyle getTextStyle(BuildContext context) {
    if (inCart) {
      return TextStyle(
          color: Colors.grey, decoration: TextDecoration.lineThrough);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print(inCart);
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: getTextStyle(context),
      ),
    );
  }
}
