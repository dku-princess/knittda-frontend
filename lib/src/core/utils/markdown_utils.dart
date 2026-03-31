String normalizeMarkdown(String raw) {
  return raw
      .replaceAll('<br/>', '  \n')
      .replaceAll('<br />', '  \n')
      .replaceAll('<br>', '  \n');
}