import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_event.dart';
import 'package:promociones_de_venta/models/promocion_model.dart';

class PromotionInputScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _discountController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _isActive = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Promoción')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese un título' : null,
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: _discountController,
                  decoration: InputDecoration(labelText: 'Descuento (%)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese un descuento' : null,
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: _conditionsController,
                  decoration: InputDecoration(labelText: 'Condiciones'),
                  maxLines: 3,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese las condiciones' : null,
                ),
                SizedBox(height: 15),
                // Switch de activo/inactivo
                ValueListenableBuilder<bool>(
                  valueListenable: _isActive,
                  builder: (context, isActive, child) {
                    return SwitchListTile(
                      title: Text('Activo'),
                      value: isActive,
                      onChanged: (value) => _isActive.value = value,
                    );
                  },
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final promotion = Promotion(
                        id: '',
                        title: _titleController.text,
                        discount: int.parse(_discountController.text),
                        isActive: _isActive.value,
                        conditions: _conditionsController.text,
                      );
                      context
                          .read<PromotionBloc>()
                          .add(AddPromotion(promotion));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
