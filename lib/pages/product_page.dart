import 'dart:convert';

import 'package:api_integration/Models/ProductsModel.dart';
import 'package:api_integration/pages/product_deatils_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  Future<ProductsModel> getProductApi()async{
    final response = await http.get(Uri.parse('https://webhook.site/b039c00e-0a2b-47b3-a2eb-9927d6fed41f'));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Api"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductApi(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading....");
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                    subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *.3 ,
                                    width: MediaQuery.of(context).size.width *1 ,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.data![index].images!.length,
                                        itemBuilder: (context, position){
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_){return ProductDetailsPage(
                                                  title: snapshot.data!.data![index].title.toString(),
                                                  price: snapshot.data!.data![index].price.toString(),
                                                  image: snapshot.data!.data![index].images![position].url.toString(),
                                                  description: snapshot.data!.data![index].shop!.description.toString(),
                                                );}));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height *.25 ,
                                            width: MediaQuery.of(context).size.width *.5 ,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                            )
                                          ),
                                      ),
                                        ),
                                      );
                                    }),
                                  ),
                                  Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite : Icons.favorite_outline),
                                ],
                              ),
                            );
                          });

                    }
                    
              }))
        ],
      ),
    );
  }
}
