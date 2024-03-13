import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                elevation: 10,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200]!, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.grey[400]!,
                  period: const Duration(milliseconds: 3000),
                  child: const ShimmerLayout(),
                ),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 10;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: containerHeight,
                  width: containerWidth * 0.2,
                  color: Colors.grey[300],
                ),
                Container(
                  height: containerHeight,
                  width: containerWidth * 0.2,
                  color: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: containerHeight,
              width: containerWidth * 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: containerHeight,
                      width: containerWidth * 0.4,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: containerHeight,
                      width: containerWidth * 0.4,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      height: containerHeight,
                      width: containerWidth * 0.4,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: containerHeight,
                      width: containerWidth * 0.4,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
