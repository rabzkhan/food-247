import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  Text(
                    cartItem.title ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ),
                  if (cartItem.size.toString() != 'null')
                    Row(
                      children: [
                        Text(
                          "Size : ${cartItem.size?.name ?? ''}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  if (cartItem.size.toString() != 'null')
                    Row(
                      children: [
                        Text(
                          "Extra : ",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                        ),
                        Wrap(
                          children: [
                            ...cartItem.extraItems!.map(
                              (element) => Text(
                                "${element.name ?? ''}, ",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          int currentQuantiy = cartItem.quantity!;
                          if (currentQuantiy > 1) {
                            currentQuantiy--;
                          }
                          controller.updateCart(cartItem, currentQuantiy);
                        },
                        icon: SvgPicture.asset(
                          AppIcons.removeQuantity,
                          height: 25.h,
                        ),
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
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          int currentQuantiy = cartItem.quantity!;
                          currentQuantiy++;
                          controller.updateCart(cartItem, currentQuantiy);
                        },
                        icon: SvgPicture.asset(
                          AppIcons.addQuantity,
                          height: 25.h,
                        ),
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
                      controller.deleteFromCart(cartItem);
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
