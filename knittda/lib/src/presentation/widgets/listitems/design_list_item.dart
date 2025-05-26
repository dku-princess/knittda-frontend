import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import '../image_box.dart';

class DesignListItem extends StatelessWidget {
  final DesignModel design;
  final VoidCallback onTap;

  DesignListItem({
    required this.design,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    design.title ?? '',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height:9),
                  Text(
                    design.designer ?? '',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            design.imageUrl != null
            ? SizedBox()
            : ImageBox(
              networkImageUrl: design.imageUrl,
              height: 60,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}