import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/core/models/cart_model.dart';
import 'package:get/get.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/api_urls.dart';
import '../../../core/constants/constants.dart';

class SingleCartItemTile extends GetView<CartController> {
  const SingleCartItemTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// Thumbnail
              SizedBox(
                width: 70,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    "${ApiUrls.baseUrl}/${cartItem.imageUrl}",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              /// Quantity and Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      cartItem.title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          int currentQuantiy = cartItem.quantity!;
                          if (currentQuantiy > 1) {
                            currentQuantiy--;
                          }
                          CartModel item = CartModel(
                            productId: cartItem.productId,
                            title: cartItem.title,
                            description: cartItem.description,
                            imageUrl: cartItem.imageUrl,
                            price: cartItem.price!,
                            quantity: currentQuantiy,
                          );
                          Get.find<CartController>().updateCart(item);
                        },
                        icon: SvgPicture.asset(AppIcons.removeQuantity),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          int currentQuantiy = cartItem.quantity!;
                          currentQuantiy++;
                          CartModel item = CartModel(
                            productId: cartItem.productId,
                            title: cartItem.title,
                            description: cartItem.description,
                            imageUrl: cartItem.imageUrl,
                            price: cartItem.price!,
                            quantity: currentQuantiy,
                          );
                          controller.updateCart(item);
                        },
                        icon: SvgPicture.asset(AppIcons.addQuantity),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              /// Price and Delete labelLarge
              Column(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.deleteCartItems(cartItem.productId!);
                    },
                    icon: SvgPicture.asset(AppIcons.delete),
                  ),
                  const SizedBox(height: 16),
                  Text('\$ ${(cartItem.price!) * (cartItem.quantity!)}'),
                ],
              )
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    );
  }
}
