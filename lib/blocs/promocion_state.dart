import 'package:equatable/equatable.dart';
import 'package:promociones_de_venta/models/promocion_model.dart';

abstract class PromotionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PromotionInitial extends PromotionState {}

class PromotionLoading extends PromotionState {}

class PromotionLoaded extends PromotionState {
  final List<Promotion> promotions;

  PromotionLoaded(this.promotions);

  @override
  List<Object?> get props => [promotions];
}

class PromotionError extends PromotionState {
  final String message;

  PromotionError(this.message);

  @override
  List<Object?> get props => [message];
}
