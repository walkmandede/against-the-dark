import 'dart:developer';

void superPrint(dynamic content, {String tag = "Tag"}) {
  log("------\n$content\n------\n", name: tag);
}
