import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/article/purchase_link_section.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseLinkSectionWidget extends StatelessWidget {
  final PurchaseLinkSection purchaseLinkSection;

  const PurchaseLinkSectionWidget({
    super.key,
    required this.purchaseLinkSection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (purchaseLinkSection.title.isNotEmpty) ...[
          Text(
            purchaseLinkSection.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 20),
        ],

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                final url = Uri.parse(purchaseLinkSection.buttonUrl);
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('링크를 열 수 없습니다.')),
                    );
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                purchaseLinkSection.buttonText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
