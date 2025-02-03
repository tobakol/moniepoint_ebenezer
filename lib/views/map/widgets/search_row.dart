import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/animations/animation_extensions.dart';

import '../../../resources/theme/app_colors.dart';

class SearchRow extends StatelessWidget {
  final double scale;

  const SearchRow({super.key, required this.scale});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 380,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Start searching",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ).animatedScale(scale: scale),
            ),
            SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.switch_access_shortcut, color: AppColors.a),
            ).animatedScale(scale: scale),
          ],
        ),
      ),
    );
  }
}
