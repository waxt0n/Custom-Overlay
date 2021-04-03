String[] settings;
PrintWriter output;

void setupSettings() {

  if (fileExists(dataPath("settings.txt"))) {

    settings = loadStrings("settings.txt");

    updateSettings();
    
  } else {
    String temp[] = {};
    saveStrings("data\\settings.txt",temp);
    setupSettings();
  }
}

void updateSettings() {
  
  images = listImageNames(dataPath(""));
  
  for (int i = 0; i < images.length; i++) {
      boolean hasIt = false;
      for (int j = 0; j < settings.length; j++) {
        if (split(settings[j], ",")[0].equals(images[i])) {
          hasIt = true;
        }
      }
      if (!hasIt) {
        settings = append(settings,images[i]+",0,0,1.00");
      }
    }
    
    settings = sort(settings);
    
    saveStrings("data\\settings.txt",settings);
    
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
