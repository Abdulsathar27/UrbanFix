import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/data/models/appointment_model.dart';
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
                              _ServiceIcon(
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
                              _StatusBadge(
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
                              _MetaChip(
                                icon: Icons.calendar_today_rounded,
                                label: controller.formatDate(appointment.date),
                              ),
                              kGapW12,
                              _MetaChip(
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
                            _ReasonBanner(
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
                                _ChatButton(
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

// ─────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────

class _ServiceIcon extends StatelessWidget {
  final String workTitle;
  final Color statusColor;

  const _ServiceIcon({required this.workTitle, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIconXLarge,
      height: kIconXLarge,
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: kBorderRadiusMedium,
      ),
      child: Icon(
        _iconForTitle(workTitle),
        size: kIconSmall,
        color: statusColor,
      ),
    );
  }

  IconData _iconForTitle(String title) {
    final t = title.toLowerCase();
    if (t.contains('plumb')) return Icons.plumbing_rounded;
    if (t.contains('electr')) return Icons.electrical_services_rounded;
    if (t.contains('clean')) return Icons.cleaning_services_rounded;
    if (t.contains('paint')) return Icons.format_paint_rounded;
    if (t.contains('carpen') || t.contains('wood')) return Icons.handyman_rounded;
    if (t.contains('mov') || t.contains('shift')) return Icons.local_shipping_rounded;
    if (t.contains('cook') || t.contains('chef')) return Icons.restaurant_rounded;
    if (t.contains('health') || t.contains('medic')) return Icons.medical_services_rounded;
    return Icons.build_circle_outlined;
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  final String label;

  const _StatusBadge({
    required this.status,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceSmall,
        vertical: kSpaceXSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: kBorderRadiusFull,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          kGapW4,
          Text(
            label,
            style: TextStyle(
              fontSize: kFontXSmall,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: kIconXSmall + 2, color: AppColors.greyMedium),
        kGapW4,
        Text(
          label,
          style: const TextStyle(
            fontSize: kFontSmall,
            color: AppColors.greyDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ReasonBanner extends StatelessWidget {
  final String reason;
  final bool isCancelled;

  const _ReasonBanner({required this.reason, required this.isCancelled});

  @override
  Widget build(BuildContext context) {
    final color = isCancelled ? AppColors.error : AppColors.greyMedium;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceSmall,
        vertical: kSpaceXSmall,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: kBorderRadiusSmall,
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCancelled ? Icons.cancel_outlined : Icons.block_rounded,
            size: kIconXSmall + 2,
            color: color,
          ),
          kGapW4,
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: kFontXSmall,
                color: color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ChatButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceMedium - 4,
          vertical: kSpaceXSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: kBorderRadiusFull,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_rounded,
              size: kIconXSmall,
              color: AppColors.white,
            ),
            SizedBox(width: kSpaceXSmall),
            Text(
              'Chat',
              style: TextStyle(
                fontSize: kFontSmall,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
