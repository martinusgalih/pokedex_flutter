import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EvolutionStepShimmer extends StatelessWidget {
  const EvolutionStepShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 18, height: 18, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Container(height: 14, color: Colors.white),
            ),
            Expanded(
              flex: 1,
              child: Container(height: 14, color: Colors.white),
            ),
            Container(width: 18, height: 18, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Container(height: 14, color: Colors.white),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}