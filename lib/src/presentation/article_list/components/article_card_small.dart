import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/article/article.dart';

class ArticleCardSmall extends StatelessWidget {
  final Article article;
  final String? imageUrl;
  final int index;

  const ArticleCardSmall({
    super.key,
    required this.article,
    this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 110,
              height: 130,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, color: Colors.white),
                        );
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      color: Colors.grey[300],
                      child: const Text(
                        '이미지 준비 중',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.category.isNotEmpty)
                    _CategoryTag(category: article.category, number: index),
                  SizedBox(height: 4),
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  if (article.interviewee.isNotEmpty) ...[
                    Text(
                      article.interviewee,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String category;
  final int number;

  const _CategoryTag({required this.category, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF7ECDC0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7ECDC0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
