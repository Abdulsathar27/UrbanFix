import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/appsize_constants.dart';
import '../../../data/controller/address_controller.dart';
import 'widget/add_address_sheet.dart';
import 'widget/address_tile.dart';
import 'widget/empty_state.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: kIconMedium),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: Consumer<AddressController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.addresses.isEmpty) {
            return EmptyState(
              onAdd: () => AddAddressSheet.show(context),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              kSpaceMedium,
              kSpaceMedium,
              kSpaceMedium,
              100,
            ),
            itemCount: controller.addresses.length,
            separatorBuilder: (_, __) => kGapH10,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return AddressTile(
                address: address,
                onDelete: () => controller.deleteAddress(address.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddAddressSheet.show(context),
        icon: const Icon(Icons.add, size: kIconMedium),
        label: const Text('Add Address'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
