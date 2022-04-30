import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tuto/modules/shop_module/controllers/ProductsController.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductsController pc = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: CupertinoSearchTextField(
              controller: pc.searchEditingController.value,
              onChanged: pc.filterIt,
              backgroundColor: Colors.white.withOpacity(0.7),
              placeholder: 'Rechercher',
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Container(
                color: Colors.white.withOpacity(0.2),
                width: double.infinity,
                child: const Center(
                  child: Text(
                    "Digital Shop",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            floating: true,
            snap: true,
            expandedHeight: 250,
            flexibleSpace: Obx(() {
              return FlexibleSpaceBar(
                background: Hero(
                  tag: "hero",
                  child: Image.network(
                    pc.randomImage.value,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Text("Error loading image"),
                    ),
                  ),
                ),
              );
            }),
          ),
          Obx(() {
            if (pc.filteredProducts.value.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Aucun produit n'est trouvé !"),
                      Text("Essayez de chercher de nouveau ! !"),
                    ],
                  ),
                ),
              );
            } else {
              return SliverGrid.count(crossAxisCount: 2, children: [
                for (var i = 0; i < pc.filteredProducts.value.length; i++)
                  Card(
                    child: InkWell(
                      onTap: () {
                        pc.viewProduct(pc.filteredProducts.value[i]);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Hero(
                              tag: pc.filteredProducts.value[i].id.toString(),
                              child: Image.network(
                                pc.filteredProducts.value[i].thumbnail!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(pc.filteredProducts.value[i].title!,
                                          style: const TextStyle(fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  Text('\$${pc.filteredProducts.value[i].discountedPrice().toStringAsFixed(2)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ]);
            }
          }),
        ],
      ),
    );
  }
}
