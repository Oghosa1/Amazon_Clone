import 'package:amazon_ui/constants/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



// class CarouselImage extends StatelessWidget {
//   const CarouselImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const double carouselHeight = 200;

//     return CarouselSlider(
//       items: GlobalVariables.carouselImages.map((i) {
//         return Builder(
//           builder: (BuildContext context) => Image.network(
//             i,
//             fit: BoxFit.cover,
//             height: carouselHeight,
//             cacheHeight: 400, // Optimize memory usage with explicit cache size
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return const Center(
//                 child: CircularProgressIndicator(color: GlobalVariables.secondaryColor),
//               );
//             },
//             errorBuilder: (context, error, stackTrace) => const Center(
//               child: Icon(Icons.error_outline, color: Colors.red, size: 40),
//             ),
//           ),
//         );
//       }).toList(),
//       options: CarouselOptions(
//         viewportFraction: 1,
//         height: carouselHeight,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//       ),
//     );
//   }
// }


class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          GlobalVariables.carouselImages.map((i) {
            return Builder(
              builder:
                  (BuildContext context) =>
                      Image.network(
                        i, 
                        fit: BoxFit.cover, 
                        height: 200,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Failed to load carousel image: $i');
                          return Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.broken_image, color: Colors.grey, size: 60),
                                SizedBox(height: 8),
                                Text('Banner not available', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          );
                        },
                      ),
            );
          }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200
      ),
    );
  }
}
