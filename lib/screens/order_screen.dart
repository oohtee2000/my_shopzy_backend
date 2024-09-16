import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopzy_ecommerce_backend/models/models.dart';
import '/controllers/controllers.dart';
import "package:intl/intl.dart";

class OrderScreen extends StatelessWidget{
  OrderScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Product'),
        backgroundColor: Colors.black,
      ),
      body:  Column(
          children: [
            Expanded(
              child: Obx( () =>
                ListView.builder(
                  itemCount: orderController.pendingOrders.length,
                  itemBuilder: (BuildContext context, int index ){
                  return  OrderCard(order: orderController.pendingOrders[index]);
                },),
              ),
            )
          ],
        ),

    );
  }
}

class OrderCard extends StatelessWidget {

  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context){

    var products = Product.products.where((product) => order.productsIds.contains(product.id)).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Order Id: ${order.id}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                  ),

                  Text(
                     DateFormat('dd-MM-yy').format(order.createdAt),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )
                  ),

                ],
              ),

              SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,

                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Row(
                      children: [
                        SizedBox(height: 50, width: 50,
                        child: Image.network(
                          products[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            products[index].name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),

                          SizedBox(
                            width: 285,
                            child: Text(
                              products[index].description,
                              style: const TextStyle(
                                fontSize: 12,

                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ),


                        ],)
                      ],
                    ),
                  );
                }
              ),


              SizedBox(height: 10),


              Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                          "DeliveryFee",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                      const SizedBox(height: 10),

                      Text(
                          "${order.deliveryFee}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      const Text(
                          "Total",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                      const SizedBox(height: 10),

                      Text(
                          "${order.total}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
              ],
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [

                  order.isAccepted

                      ? ElevatedButton(
                      onPressed: (){
                        orderController.updateOrder(
                          order,
                          'isDelivered',
                          !order.isDelivered,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(150, 40)
                      ),
                      child: const Text(
                          "Deliver",
                          style: const TextStyle(
                            fontSize: 12,
                          )
                      )
                  )

                      : ElevatedButton(
                      onPressed: (){
                        orderController.updateOrder(
                            order,
                            'isAccepted',
                            !order.isAccepted,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        minimumSize: const Size(150, 40)
                      ),
                      child: const Text(
                          "Accept",
                          style: const TextStyle(
                            fontSize: 12,
                          )
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        orderController.updateOrder(
                          order,
                          'isCancelled',
                          !order.isCancelled,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(150, 40)
                      ),
                      child: const Text(
                          "Cancel",
                          style: const TextStyle(
                            fontSize: 12,
                          )
                      )
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}