// OLD CODE had floatingActionButton: FloatingChatButton(),

// NEW CODE (optional - remove or keep based on your design):
import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/home/widget/floating_chat_button.dart';
import 'package:frontend/presentation/screens/home/widget/main_navigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/home/widget/home_header.dart';
import 'package:frontend/presentation/screens/home/widget/search_bar_widget.dart';
import 'package:frontend/presentation/screens/home/widget/recent_booking_card.dart';
import 'package:frontend/presentation/screens/home/widget/service_card.dart';
// import 'package:frontend/presentation/screens/home/widget/floating_chat_button.dart'; // Remove if not needed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const HomeHeader(),
                SearchBarWidget(
                  controller: controller.searchController,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.services.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceCards(
                        title: controller.services[index],
                      );
                    },
                  ),
                ),
                if (controller.currentAppointment != null)
                  RecentBookingCard(
                    appointment: controller.currentAppointment!,
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingChatButton(), 
      
        );

      },
    );
  }
}