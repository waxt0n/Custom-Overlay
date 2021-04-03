String[] settings;
PrintWriter output;

void setupSettings() {

  if (fileExists(dataPath("settings.txt"))) {

    settings = loadStrings("settings.txt");
    for (int i = 0; i != images.length; i++) {
      boolean hasIt = false;
      for (int j = 0; j != settings.length; j++) {
        if (split(settings[j], ",")[0] == images[i]) {
          hasIt = true;
        }
      }
      if (!hasIt) {
        output.println(images[i]+",0,0,1");
        output.flush();
      }
    }
  }
}

boolean fileExists(String path) {
  File file=new File(path);
  boolean exists = file.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}
