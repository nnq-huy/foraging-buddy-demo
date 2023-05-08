List<String> getImageFileNames(String name) {
  List<String> fileNames = [];
  for (var i = 1; i < 4; i++) {
    fileNames.add('assets/mushroom_img/${name.replaceFirst(' ', '_')}_$i.jpeg');
  }
  return fileNames;
}
