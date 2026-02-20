import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/home/widget/bottom_nav_bar.dart';
import 'package:frontend/presentation/screens/home/widget/home_header.dart';
import 'package:frontend/presentation/screens/home/widget/promo_banner.dart';
import 'package:frontend/presentation/screens/home/widget/recent_booking_card.dart';
import 'package:frontend/presentation/screens/home/widget/search_bar_widget.dart';
import 'package:frontend/presentation/screens/home/widget/service_card.dart';
import 'package:provider/provider.dart';
import '../../../data/controller/appointment_controller.dart';
import '../../../data/controller/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Call API after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          context.read<AppointmentController>();

      if (controller.appointments.isEmpty) {
        controller.fetchAppointments();
      }
    });

    return Scaffold(
      bottomNavigationBar:
          const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: Consumer2<UserController,
            AppointmentController>(
          builder: (context, userController,
              appointmentController, _) {

            final user =
                userController.currentUser;

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // ================= Header
                  HomeHeader(
                      key: ValueKey(
                        user?.id ?? "header"),
                  ),

                  const SizedBox(height: 20),

                  // ================= Search
                  const SearchBarWidget(),

                  const SizedBox(height: 24),

                  // ================= Promo
                  const PromoBanner(),

                  const SizedBox(height: 30),

                  // ================= Services
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Our Services",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      ServiceCard(
                          icon: Icons.plumbing,
                          label: "Plumbing"),
                      ServiceCard(
                          icon: Icons.electric_bolt,
                          label: "Electrical"),
                      ServiceCard(
                          icon: Icons.cleaning_services,
                          label: "Cleaning"),
                      ServiceCard(
                          icon: Icons.format_paint,
                          label: "Painting"),
                      ServiceCard(
                          icon: Icons.handyman,
                          label: "Carpentry"),
                      ServiceCard(
                          icon: Icons.local_shipping,
                          label: "Moving"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ================= Recent Bookings
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Recent Bookings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      Text(
                        "History",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  ...appointmentController
                      .appointments
                      .take(2)
                      .map((appointment) =>
                          RecentBookingCard(
                            appointment:
                                appointment,
                          )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}