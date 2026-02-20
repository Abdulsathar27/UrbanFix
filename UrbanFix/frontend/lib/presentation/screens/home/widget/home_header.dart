import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/controller/user_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, _) {

        final user = userController.currentUser;

        return Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [

            /// ================= USER INFO
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back,",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Hello, ${user?.name ?? "User"}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            /// ================= LOCATION
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    user?.id ?? "Location",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}