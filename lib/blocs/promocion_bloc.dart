import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_event.dart';
import 'package:promociones_de_venta/blocs/promocion_state.dart';
import 'package:promociones_de_venta/repositorio/promocion_repositorio.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final PromotionRepository promotionRepository;

  PromotionBloc({required this.promotionRepository})
      : super(PromotionInitial()) {
    on<FetchPromotions>((event, emit) async {
      emit(PromotionLoading());
      try {
        final promotions = await promotionRepository.fetchPromotions();
        emit(PromotionLoaded(promotions));
      } catch (e) {
        emit(PromotionError(e.toString()));
      }
    });

    on<AddPromotion>((event, emit) async {
      try {
        await promotionRepository.addPromotion(event.promotion);
        add(FetchPromotions());
      } catch (e) {
        emit(PromotionError(e.toString()));
      }
    });
  }
}
