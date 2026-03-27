import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/home/widget/floating_chat_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/home/widget/home_header.dart';
import 'package:frontend/presentation/screens/home/widget/search_bar_widget.dart';
import 'package:frontend/presentation/screens/home/widget/recent_booking_card.dart';
import 'package:frontend/presentation/screens/home/widget/services_header.dart';
import 'package:frontend/presentation/screens/home/widget/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, child) {
        final services = controller.services;

        return Scaffold(
          floatingActionButton: const FloatingChatButton(),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const HomeHeader()),
                SliverToBoxAdapter(
                  child: SearchBarWidget(
                      controller: controller.searchController),
                ),

                // Recent booking section — always visible
                SliverToBoxAdapter(
                  child: RecentBookingCard(
                    appointment: controller.currentAppointment,
                  ),
                ),

                SliverToBoxAdapter(
                  child: const ServicesHeader(title: "Our Services"),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final service = services[index];
                        return ServiceCard(
                          title: service.name,
                          icon: service.icon,
                          iconColor: service.color,
                          onTap: () {
                            context.go('/service-details', extra: service);
                          },
                        );
                      },
                      childCount: services.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
