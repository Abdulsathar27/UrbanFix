import 'package:flutter/material.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            /// Add Photo Card
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(height: 6),
                  Text("Add Photo",
                      style: TextStyle(fontSize: 12))
                ],
              ),
            ),

            const SizedBox(width: 15),

            /// Preview Image
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/sample_road.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close,
                          size: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 15),

            /// Empty Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE4E8F0),
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: const Icon(Icons.image,
                  color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "You can upload up to 3 photos. Max size 5MB each.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}