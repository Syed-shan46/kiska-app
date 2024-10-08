import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.price,
      required this.onTap,
      required this.category});

  final String imageUrl;
  final String productName;
  final String category;
  final double price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.contain,
                height: 120,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '₹$price',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      )),
                  Container(
                    decoration:const  BoxDecoration(
                      
                      color: Color(0xFF2F3645),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const SizedBox(
                      height: 38,
                      width: 38,
                      child: Icon(
                        Iconsax.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
