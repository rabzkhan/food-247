import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/product_controller.dart';
import 'package:food/views/cart/cart_page.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/network_image.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/constants/api_urls.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/models/cart_model.dart';
import '../../core/models/product_details_model.dart';
import '../../core/models/product_list_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Products products;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductController productController = Get.put(ProductController());
  CartController cartController = Get.put(CartController());

  int currentQuantiy = 1;
  double productPrice = 0;
  double extraItemPrice = 0;
  double totalPrice = 0;

  int selectedSizeIndex = 0;
  List<int> selectedExtraIndex = [];
  List<ExtraItem> extraItems = [];
  PSize? pSize;

  calculatePrice() {
    totalPrice = currentQuantiy * productPrice;
    // Add the prices of extra items
    if (extraItems.isNotEmpty) {
      for (ExtraItem extraItem in extraItems) {
        totalPrice += extraItem.price ?? 0;
      }
    }
  }

  @override
  void initState() {
    productController.getProductDetails(widget.products.productNameId!);
    totalPrice = double.parse(widget.products.price.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Product Details'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDefaults.padding,
            ),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => const CartPage());
                  },
                  child: SvgPicture.asset(AppIcons.shoppingCart),
                ),
                const SizedBox(width: AppDefaults.padding),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel item = CartModel(
                        productId: int.parse(widget.products.productNameId.toString()),
                        title: widget.products.productName.toString(),
                        description: widget.products.description.toString(),
                        imageUrl: widget.products.imagePath.toString(),
                        price: totalPrice,
                        quantity: currentQuantiy,
                        size: PSize(
                          id: pSize?.id ?? 0,
                          name: pSize?.name ?? "",
                          price: pSize?.price ?? 0.0,
                        ),
                        extraItems: extraItems,
                      );
                      Get.find<CartController>().addToCart(item);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(AppDefaults.padding * 1.2),
                    ),
                    child: Text('Add to Cart ${totalPrice.toStringAsFixed(2)}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImagesSlider(
              images: [
                "${ApiUrls.baseUrl}/${widget.products.imagePath}",
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              child: Text(
                widget.products.productName ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Row(
                children: [
                  Text(
                    'Product Details',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (currentQuantiy > 1) {
                            currentQuantiy--;
                          }
                          calculatePrice();
                          setState(() {});
                        },
                        icon: SvgPicture.asset(AppIcons.removeQuantity),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentQuantiy.toString(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          currentQuantiy++;
                          calculatePrice();
                          setState(() {});
                        },
                        icon: SvgPicture.asset(AppIcons.addQuantity),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10).r,
              child: Text(widget.products.description ?? ''),
            ),
            Obx(() {
              if (productController.isProductDetailsLoading.value) {
                return const SizedBox();
              }
              if (productController.productSizes.isEmpty) {
                return const SizedBox();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Size",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                        height: 40.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.productSizes.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductSize productSize = productController.productSizes[index];
                            pSize = PSize(
                              id: productSize.id,
                              name: productSize.name,
                              price: double.parse(
                                productSize.sizePrice.toString(),
                              ),
                            );
                            return GestureDetector(
                              onTap: () {
                                selectedSizeIndex = index;
                                productPrice = double.parse(productSize.sizePrice.toString());
                                pSize = PSize(
                                  id: productController.productSizes[index].id,
                                  name: productController.productSizes[index].name,
                                  price: double.parse(
                                    productController.productSizes[index].sizePrice.toString(),
                                  ),
                                );
                                calculatePrice();
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedSizeIndex == index
                                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedSizeIndex == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColor.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                ),
                                margin: const EdgeInsets.only(right: 15).r,
                                child: Center(
                                  child: Text(
                                    "${productSize.name ?? ''} \$${productSize.sizePrice ?? ''}",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              );
            }),
            10.verticalSpace,
            Obx(
              () {
                if (productController.isProductDetailsLoading.value) {
                  return const SizedBox();
                }
                if (productController.productExtraItems.isEmpty) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Extra",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.productExtraItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductExtraItem extraItem = productController.productExtraItems[index];
                            return GestureDetector(
                              onTap: () {
                                ExtraItem temItem;
                                temItem = ExtraItem(
                                  id: productController.productExtraItems[index].id,
                                  name: productController.productExtraItems[index].name,
                                  price: double.parse(productController.productExtraItems[index].price.toString()),
                                );
                                if (!selectedExtraIndex.contains(index)) {
                                  selectedExtraIndex.add(index);
                                  extraItems.add(temItem);
                                } else {
                                  selectedExtraIndex.remove(index);
                                  extraItems.removeWhere(
                                    (element) => element.id == temItem.id,
                                  );
                                }
                                calculatePrice();
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedExtraIndex.contains(index)
                                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedExtraIndex.contains(index)
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColor.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
                                margin: const EdgeInsets.only(right: 15),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: NetworkImageWithLoader(
                                          "${ApiUrls.baseUrl}/${extraItem.image}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          extraItem.name ?? '',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Text(
                                          '\$${extraItem.price}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
