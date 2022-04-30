import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ProductsController.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key) {
    currentImage.value = pc.product.value!.thumbnail!;
  }

  final ProductsController pc = Get.put(ProductsController());

  var currentImage = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 370,
            pinned: true,
            leading: SizedBox(
              width: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.1),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Obx(() {
                return Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: pc.product.value!.id.toString(),
                        child: Image.network(
                          currentImage.value,
                          fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: SafeArea(
                        child: CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.9),
                          radius: 30,
                          child: Text(
                            '-${pc.product.value!.discountPercentage}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: pc.product.value!.images!.map((e) {
                  return GestureDetector(
                    onTap: () {
                      currentImage.value = e;
                    },
                    child: Obx(() {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: Hero(
                          tag: e,
                          child: Image.network(
                            e,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: currentImage.value == e ? Colors.red : Colors.grey,
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${pc.product.value!.title}', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    '${pc.product.value!.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(
                        text: '\$${pc.product.value!.discountedPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${pc.product.value!.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) {
                              return Icon(Icons.star,
                                  size: 16,
                                  color:
                                      (index + 1) <= pc.product.value!.rating!.toInt() ? Colors.orange : Colors.grey);
                            },
                          ).toList(),
                          // pc.product.value!.rating.,
                          Text(pc.product.value!.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${pc.product.value!.category}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Text(
                            'Category',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${pc.product.value!.brand}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Text(
                            'Brand',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                      child: const Text('Buy'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
