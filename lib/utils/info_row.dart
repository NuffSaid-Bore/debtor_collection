import 'package:flutter/material.dart';

enum IconPosition {
  beforeText,
  afterText,
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final IconPosition iconPosition;

  const InfoRow({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.iconPosition = IconPosition.beforeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconPosition == IconPosition.beforeText)
          _buildIconContainer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            Text(
              value,
              style:  TextStyle(
                color: Colors.deepPurple[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (iconPosition == IconPosition.afterText)
          _buildIconContainer(),
      ],
    );
  }

  Widget _buildIconContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        child:  Center(
          child: Icon(icon, color: iconColor)
        ),
      ),
    );
  }
}