import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  final GroceryItem item;

  final Function(bool?)? onComplete;

  final TextDecoration textDecoration;

  GroceryTile({Key? key, required this.item, this.onComplete})
      : textDecoration = (item.isComplete
            ? TextDecoration.lineThrough
            : TextDecoration.none),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(color: item.color, width: 5),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.lato(
                        decoration: textDecoration,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  _buildDate(item),
                  const SizedBox(height: 4),
                  _buildImportance(item),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(item.quantity.toString()),
              _buildCheckbox(item, onComplete)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImportance(GroceryItem item) {
    if (item.importance == Importance.low) {
      return Text('Low', style: GoogleFonts.lato(decoration: textDecoration));
    } else if (item.importance == Importance.medium) {
      return Text('Medium',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w800, decoration: textDecoration));
    } else if (item.importance == Importance.high) {
      return Text('High',
          style: GoogleFonts.lato(
              color: Colors.red,
              fontWeight: FontWeight.w900,
              decoration: textDecoration));
    } else {
      throw Exception('This importance type does not exits');
    }
  }

  Widget _buildDate(GroceryItem item) {
    final dateFormatter = DateFormat('MMMM dd hh:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget _buildCheckbox(GroceryItem item, Function(bool?)? onComplete) {
    return Checkbox(value: item.isComplete, onChanged: onComplete);
  }
}
