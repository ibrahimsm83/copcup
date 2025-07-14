import 'package:flutter_application_copcup/src/common/constants/app_images.dart';

class ResponsibleOrderModel {
  final String? image;
  final String? name;
  final String? variation;
  final String? orderId;
  final String? seller;
  final String? dayAndTime;
  final String? itemCount;
  final String? price;
  ResponsibleOrderModel({
    required this.image,
    required this.name,
    this.variation,
    this.seller,
    this.orderId,
    this.dayAndTime,
    this.itemCount,
    this.price,
  });
}

List<ResponsibleOrderModel> responsibleOrderCompleteList = [
  ResponsibleOrderModel(
      image: AppImages.kfcBroast,
      name: 'Nike Sneakers',
      orderId: '3132436',
      dayAndTime: '29 Nov, 01:20 pm ',
      itemCount: '2 items',
      price: '50.00'),
  ResponsibleOrderModel(
      image: AppImages.chickenCurry,
      name: 'Chicken Curry',
      orderId: '3132436',
      dayAndTime: '29 Nov, 01:20 pm ',
      itemCount: '2 items',
      price: '50.00'),
  ResponsibleOrderModel(
      image: AppImages.desiBariyani,
      name: 'Chicken Curry',
      orderId: '3132436',
      dayAndTime: '29 Nov, 01:20 pm ',
      itemCount: '2 items',
      price: '50.00'),
];
List<ResponsibleOrderModel> responsibleInProgressList = [
  ResponsibleOrderModel(
      image: AppImages.kfcBroast,
      name: 'Nike Sneakers',
      seller: 'M.Arslan',
      variation: 'Spicy',
      price: '\$34.00'),
  ResponsibleOrderModel(
      image: AppImages.kfcBroast,
      name: 'Nike Sneakers',
      seller: 'M.Arslan',
      variation: 'Spicy',
      price: '\$34.00'),
];
