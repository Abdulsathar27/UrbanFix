import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/presentation/screens/appointment/widget/chat_button.dart';
import 'package:frontend/presentation/screens/appointment/widget/meta_chip.dart';
import 'package:frontend/presentation/screens/appointment/widget/reason_banner.dart';
import 'package:frontend/presentation/screens/appointment/widget/service_icon.dart';
import 'package:frontend/presentation/screens/appointment/widget/status_badge.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppointmentListTile extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isUpcoming;
  final VoidCallback? onTap;
  final AppointmentController controller;

  const AppointmentListTile({
    super.key,
    required this.appointment,
    required this.isUpcoming,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(appointment.status);
    final workerName = controller.getWorkerName(appointment);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kSpaceXSmall,
        horizontal: kSpaceSmall,
      ),
      child: Material(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: kBorderRadiusLarge,
        elevation: isDark ? 0 : 2,
        shadowColor: Colors.black12,
        child: InkWell(
          onTap: onTap,
          borderRadius: kBorderRadiusLarge,
          child: ClipRRect(
            borderRadius: kBorderRadiusLarge,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left accent bar
                  Container(width: 4, color: statusColor),

                  // Card body
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        kSpaceMedium,
                        kSpaceMedium,
                        kSpaceMedium,
                        kSpaceSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Header row ──
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ServiceIcon(
                                workTitle: appointment.workTitle,
                                statusColor: statusColor,
                              ),
                              kGapW12,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment.workTitle,
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: kFontBase,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    kGapH4,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline_rounded,
                                          size: kIconXSmall,
                                          color: AppColors.greyMedium,
                                        ),
                                        kGapW4,
                                        Expanded(
                                          child: Text(
                                            workerName,
                                            style: const TextStyle(
                                              fontSize: kFontSmall,
                                              color: AppColors.greyDark,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              kGapW8,
                              StatusBadge(
                                status: appointment.status,
                                color: statusColor,
                                label: controller.formatStatus(appointment.status),
                              ),
                            ],
                          ),

                          kGapH12,
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: isDark
                                ? Colors.white10
                                : AppColors.greyLight,
                          ),
                          kGapH10,

                          // ── Meta row ──
                          Row(
                            children: [
                              MetaChip(
                                icon: Icons.calendar_today_rounded,
                                label: controller.formatDate(appointment.date),
                              ),
                              kGapW12,
                              MetaChip(
                                icon: Icons.schedule_rounded,
                                label: controller.formatTime(appointment.time),
                              ),
                              const Spacer(),
                              if (appointment.requestedWage > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kSpaceSmall,
                                    vertical: kSpaceXSmall / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success
                                        .withValues(alpha: 0.1),
                                    borderRadius: kBorderRadiusFull,
                                  ),
                                  child: Text(
                                    controller.formatCurrency(
                                      appointment.requestedWage,
                                    ),
                                    style: const TextStyle(
                                      fontSize: kFontSmall,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          // ── Cancel / Reject reason ──
                          if (!isUpcoming &&
                              (appointment.cancelReason != null ||
                                  appointment.rejectReason != null)) ...[
                            kGapH8,
                            ReasonBanner(
                              reason: appointment.cancelReason ??
                                  appointment.rejectReason!,
                              isCancelled:
                                  appointment.status == 'cancelled',
                            ),
                          ],

                          // ── Footer actions (upcoming only) ──
                          if (isUpcoming) ...[
                            kGapH10,
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: isDark
                                  ? Colors.white10
                                  : AppColors.greyLight,
                            ),
                            kGapH8,
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.tapForDetails,
                                      style: TextStyle(
                                        fontSize: kFontSmall,
                                        color: AppColors.primary
                                            .withValues(alpha: 0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 10,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                                ChatButton(
                                  onTap: () => _openChat(context),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openChat(BuildContext context) {
    final currentUserId =
        context.read<UserController>().currentUser?.id ?? '';
    if (currentUserId.isEmpty || appointment.workerId.isEmpty) return;

    final chatStringId = ChatController.buildChatStringId(
      currentUserId,
      appointment.workerId,
    );
    context.pushNamed(
      'chatDetails',
      pathParameters: {'chatId': chatStringId},
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.warning;
      case 'accepted':
        return AppColors.primary;
      case 'confirmed':
        return AppColors.success;
      case 'completed':
        return AppColors.info;
      case 'cancelled':
        return AppColors.error;
      case 'rejected':
        return AppColors.greyMedium;
      default:
        return AppColors.greyMedium;
    }
  }
}









