import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/address_picker.dart';
import 'package:frontend/presentation/screens/booking/widgets/field.dart';
import 'package:provider/provider.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_pin_circle_rounded, size: kIconSmall, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  AppStrings.customerDetails,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            kGapH12,
            Field(
              label: AppStrings.labelName,
              hint: AppStrings.hintFullName,
              icon: Icons.person_outline_rounded,
              onChanged: (v) => controller.customerName = v,
              textInputAction: TextInputAction.next,
            ),
            kGapH12,
            Field(
              label: AppStrings.labelPhone,
              hint: AppStrings.hintPhoneNumber,
              icon: Icons.phone_outlined,
              onChanged: (v) => controller.customerPhone = v,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            kGapH12,
            AddressPicker(onAddressSelected: (v) => controller.customerAddress = v),
          ],
        );
      },
    );
  }
}
