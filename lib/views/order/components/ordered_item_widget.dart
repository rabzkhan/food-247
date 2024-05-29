import 'package:flutter/material.dart';
import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/core/models/order_list_model.dart';
import 'package:get/get.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/api_urls.dart';
import '../../../core/constants/constants.dart';

class OrderedItemWidget extends GetView<CartController> {
  const OrderedItemWidget({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);
  final OrderDetail orderDetail;

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
                    "${ApiUrls.baseUrl}/${orderDetail.imageUrl}",
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
                    orderDetail.title ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ),
                  if (orderDetail.sizeName.toString() != 'null')
                    Row(
                      children: [
                        Text(
                          "Size : ${orderDetail.sizeName ?? ''}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  if (orderDetail.extraItems!.isEmpty)
                    Row(
                      children: [
                        Text(
                          "Extra : ",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                        ),
                        Wrap(
                          children: [
                            ...orderDetail.extraItems!.map(
                              (element) => Text(
                                "${element.extraItemName ?? ''}, ",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                ],
              ),
              const Spacer(),

              /// Price and Delete labelLarge
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text('\$ ${double.parse(orderDetail.price!).toStringAsFixed(2)}'),
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
