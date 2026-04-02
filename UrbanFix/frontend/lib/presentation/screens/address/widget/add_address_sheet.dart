import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/address_controller.dart';
import 'package:provider/provider.dart';

class AddAddressSheet extends StatelessWidget {
  const AddAddressSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(kRadiusXLarge)),
      ),
      builder: (_) => const AddAddressSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddressController>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        kSpaceLarge,
        kSpaceLarge,
        kSpaceLarge,
        kSpaceLarge + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
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
            'Add New Address',
            style: TextStyle(fontSize: kFontLarge, fontWeight: FontWeight.bold),
          ),
          kGapH16,

          // Label selector
          const Text(
            'Label',
            style: TextStyle(fontSize: kFontSmall, fontWeight: FontWeight.w500),
          ),
          kGapH8,
          Row(
            children: AddressController.labels.map((label) {
              final selected = controller.selectedLabel == label;
              return Padding(
                padding: const EdgeInsets.only(right: kSpaceSmall),
                child: ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => controller.setLabel(label),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : null,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  backgroundColor: AppColors.greyBackground,
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
          kGapH16,

          // Address input
          const Text(
            'Address',
            style: TextStyle(fontSize: kFontSmall, fontWeight: FontWeight.w500),
          ),
          kGapH8,
          TextField(
            controller: controller.addressTextController,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Enter full address',
              hintStyle: const TextStyle(
                color: AppColors.greyMedium,
                fontSize: kFontMedium,
              ),
              filled: true,
              fillColor: AppColors.greyBackground,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kSpaceMedium,
                vertical: kSpaceSmall + kSpaceXSmall,
              ),
              border: OutlineInputBorder(
                borderRadius: kBorderRadiusMedium,
                borderSide: BorderSide.none,
              ),
            ),
          ),
          kGapH20,

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final saved = await controller.addAddress();
                if (saved && context.mounted) {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: kSpaceMedium),
                shape: RoundedRectangleBorder(
                  borderRadius: kBorderRadiusMedium,
                ),
              ),
              child: const Text(
                'Save Address',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
