import 'package:equatable/equatable.dart';
import 'package:promociones_de_venta/models/promocion_model.dart';

abstract class PromotionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPromotions extends PromotionEvent {}

class AddPromotion extends PromotionEvent {
  final Promotion promotion;

  AddPromotion(this.promotion);

  @override
  List<Object?> get props => [promotion];
}
