String[] settings;
PrintWriter output;

void setupSettings() {

  if (fileExists(dataPath("settings.txt"))) {

    settings = loadStrings("settings.txt");

    updateSettings();
  } else {
    String temp[] = {};
    saveStrings("data\\settings.txt", temp);
    setupSettings();
  }
}

void updateSettings() {

  images = listImageNames(dataPath(""));
  
  String[] temp = settings;
  String[] temp2 = {};
  settings = temp2;

  for (int i = 0; i < images.length; i++) {
    boolean hasIt = false;
    int position = 0;
    for (int j = 0; j < temp.length; j++) {
      if (split(temp[j], ",")[0].equals(images[i])) {
        hasIt = true;
        position = j;
      }
    }
    if (hasIt) {
      switch(split(temp[position],",").length) {
        case 1:
          temp[position] = temp[position] + ",0,0,1.000,1.000";
        case 2:
          temp[position] = temp[position] + ",0,1.000,1.000";
        case 3:
          temp[position] = temp[position] + ",1.000,1.000";
        case 4:
          temp[position] = temp[position] + ",1.000";
      }
      settings = append(settings, temp[position]);
    } else {
      settings = append(settings, images[i]+",0,0,1.000,1.000");
    }
  }

  settings = sort(settings);
  saveStrings("data\\settings.txt", settings);
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
