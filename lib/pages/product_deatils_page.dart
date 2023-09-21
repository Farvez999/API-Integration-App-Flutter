import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String description;
  const ProductDetailsPage({
    super.key, required this.title, required this.price, required this.image, required this.description});

  void addToCart(BuildContext context){
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              Text(title),
              const Text("Successfully added to cart", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
            ],
          ),
        ),
        actions: [
          //   Okay button
          IconButton(onPressed: (){
            //   pop once to remove dialog box
            Navigator.pop(context);

            //   pop again to go previous screen
            Navigator.pop(context);


          }, icon: const Icon(Icons.done, color: Colors.white,))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image(image: NetworkImage(image)),
            SizedBox(height: 10,),
            Row(
                children: [
                  Text("Name : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
            ),
            Row(
              children: [
                Text("Price : \$ ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Expanded(child: Text(description + "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.", style: TextStyle(fontSize: 18), maxLines: 10,)),
              ],
            ),
            ElevatedButton(onPressed: (){addToCart(context);}, child: Text("Add To Card"))
          ],

        ),
      ),
    );
  }
}
