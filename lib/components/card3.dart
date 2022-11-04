import 'package:flutter/material.dart';
import 'package:structureflutter/theme/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(width: 350, height: 450),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/mag2.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.black, width: 2.0),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.book, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(
                  'Recipe Trends',
                  style: FooderlichTheme.darkTextTheme.headline2,
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Positioned(
            top: 120,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 12,
              children: [
                Chip(
                  label: Text(
                    'Healthy',
                    style: FooderlichTheme.darkTextTheme.bodyText1,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  onDeleted: () {},
                ),
                Chip(
                  label: Text('Vegan',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  onDeleted: () {},
                ),
                Chip(
                  label: Text('Carrots',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                  backgroundColor: Colors.black.withOpacity(0.7),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
