import 'package:knittda/src/domain/model/article/article_preview.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetArticlePreviewsUseCase {
  final ProjectApiRepository _repository;

  GetArticlePreviewsUseCase(this._repository);

  Future<List<ArticlePreview>> call({required List<int> ids}) async {
    return await _repository.getArticlePreviews(ids: ids);
  }
}