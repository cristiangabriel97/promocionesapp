import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_state.dart';
import 'package:promociones_de_venta/screens/ingresodatos_screen.dart';
// Asegúrate de importar la pantalla de ingreso.

class PromotionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Promociones')),
      body: BlocBuilder<PromotionBloc, PromotionState>(
        builder: (context, state) {
          if (state is PromotionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PromotionLoaded) {
            if (state.promotions.isEmpty) {
              return Center(child: Text('No hay promociones registradas.'));
            }
            return ListView.builder(
              itemCount: state.promotions.length,
              itemBuilder: (context, index) {
                final promotion = state.promotions[index];
                return ListTile(
                  title: Text(promotion.title),
                  subtitle: Text('Descuento: ${promotion.discount}%'),
                  trailing: Switch(
                    value: promotion.isActive,
                    onChanged: null, // Solo visual
                  ),
                );
              },
            );
          } else if (state is PromotionError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PromotionInputScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar Promoción',
      ),
    );
  }
}
