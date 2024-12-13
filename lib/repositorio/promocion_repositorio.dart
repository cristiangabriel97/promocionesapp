import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promociones_de_venta/models/promocion_model.dart';

class PromotionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todas las promociones
  Future<List<Promotion>> fetchPromotions() async {
    final snapshot = await _firestore.collection('promotions').get();
    return snapshot.docs
        .map((doc) => Promotion.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Agregar una promoción
  Future<void> addPromotion(Promotion promotion) async {
    await _firestore.collection('promotions').add(promotion.toMap());
  }
}
