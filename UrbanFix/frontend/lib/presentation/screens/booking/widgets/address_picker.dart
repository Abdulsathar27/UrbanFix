import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/address_controller.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/presentation/screens/booking/widgets/address_picker_sheet.dart';
import 'package:provider/provider.dart';

class AddressPicker extends StatelessWidget {
  final ValueChanged<String> onAddressSelected;

  const AddressPicker({super.key, required this.onAddressSelected});

  IconData _iconFor(String? label) {
    switch (label) {
      case 'Home':
        return Icons.home_outlined;
      case 'Work':
        return Icons.work_outline;
      default:
        return Icons.location_on_outlined;
    }
  }

  Future<void> _openPicker(BuildContext context) async {
    final addrCtrl = context.read<AddressController>();
    final result = await showModalBottomSheet<AddressModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ChangeNotifierProvider.value(
        value: addrCtrl,
        child: const AddressPickerSheet(),
      ),
    );

    if (result != null && context.mounted) {
      context.read<AddressController>().selectAddress(result);
      onAddressSelected(result.address);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = Theme.of(context).inputDecorationTheme.fillColor;

    return Consumer<AddressController>(
      builder: (context, controller, _) {
        final selected = controller.selectedAddress;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.labelAddress,
              style: TextStyle(
                fontSize: kFontSmall,
                fontWeight: FontWeight.w600,
                color: AppColors.greyDark,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => _openPicker(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(_iconFor(selected?.label), size: kIconSmall, color: AppColors.primary),
                    kGapW10,
                    Expanded(
                      child: selected == null
                          ? const Text(
                              AppStrings.hintAddress,
                              style: TextStyle(color: AppColors.greyMedium, fontSize: 13),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: kSpaceSmall, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    selected.label,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                kGapH4,
                                Text(
                                  selected.address,
                                  style: const TextStyle(fontSize: 13),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: AppColors.greyMedium),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
