String[] settings;
PrintWriter output;

void setupSettings() {
  if (fileExists(dataPath("settings.txt"))) {

    settings = loadStrings("settings.txt");
    
    output.println("test");
    output.flush();
    
  
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
