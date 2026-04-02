import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/booking/widgets/selectable_tile.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/address_controller.dart';
import 'package:frontend/data/models/address_model.dart';

class AddressPickerSheet extends StatelessWidget {
  const AddressPickerSheet({super.key});

  void _selectAddress(BuildContext context, AddressModel address) =>
      Navigator.pop(context, address);

  void _confirmManual(BuildContext context, AddressController controller) {
    final text = controller.addressTextController.text.trim();
    if (text.isEmpty) return;
    Navigator.pop(context, AddressModel.create(label: 'Other', address: text));
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.78),
      child: Consumer<AddressController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(kSpaceLarge, kSpaceLarge, kSpaceLarge, kSpaceLarge + bottomInset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: kWidth40,
                    height: kHeight4,
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: kBorderRadiusXSmall,
                    ),
                  ),
                ),
                kGapH20,
                const Text(
                  'Select Address',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                kGapH16,
                if (controller.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else ...[
                  if (controller.addresses.isNotEmpty) ...[
                    for (final address in controller.addresses)
                      SelectableTile(
                        address: address,
                        onTap: () => _selectAddress(context, address),
                      ),
                    kGapH12,
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or enter manually',
                            style: TextStyle(
                              fontSize: kFontSmall,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    kGapH12,
                  ],
                  TextField(
                    controller: controller.addressTextController,
                    maxLines: 2,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Enter full address',
                      hintStyle: const TextStyle(color: AppColors.greyMedium, fontSize: kFontMedium),
                      filled: true,
                      fillColor: AppColors.greyBackground,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: kBorderRadiusMedium,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  kGapH12,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _confirmManual(context, controller),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: kSpaceMedium),
                        shape: RoundedRectangleBorder(borderRadius: kBorderRadiusMedium),
                      ),
                      child: const Text(
                        AppStrings.confirm,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
