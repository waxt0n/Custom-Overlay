boolean keyPressTypeBox=false;
class TypeBox {
  boolean typeBoxActive=false;
  float x;
  float y;
  float w;
  float h;
  boolean e;
  boolean le;
  String entry;
  TypeBox(int _x, int _y, int _w, int _h) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    e=false;
    le=false;
  }
  void doCommon(int numMode) {
    pushStyle();
    le=e;
    if (mousePressed&&mInC(x, y, w, h)&&!typeBoxActive) {
      e=true;
      typeBoxActive=true;
    }
    if (mousePressed&&!mInC(x, y, w, h)&&typeBoxActive) {
      e=false;
      typeBoxActive=false;
      keyPressTypeBox=false;
    }
    if (keyPressTypeBox&&e) {
      if (key==ENTER||key==RETURN||keyCode==66) {
        e=false;
        typeBoxActive=false;
        keyPressTypeBox=false;
      }
      if (key==DELETE) {
        e=false;
        entry="";
        typeBoxActive=false;
        keyPressTypeBox=false;
      }
    }
    if (e&&!le) {//just activated
      entry="";
    }
    textSize(h*.75);
    if (e) {
      if (keyPressTypeBox&&textWidth(entry)<w-h*.75) {
        if (numMode==0&&(((key>=32&&key<=126)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key; //letters and numbers
        }
        if (numMode==1&&((key==45||(key>=48&&key<=57)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key;//numbers and negative
        }
        if (numMode==2&&((key==45||key==46||(key>=48&&key<=57)) && (key != CODED))) {        
          keyPressTypeBox=false;
          entry+=key;//numbers, negative, and decimal
        }
      }
      if (keyPressTypeBox&&(key==BACKSPACE||keyCode==67)&&entry.length()>0) {        
        keyPressTypeBox=false;
        entry=entry.substring(0, entry.length()-1);
        if (entry.length()==0) {
          entry="";
        }
      }
    }
    stroke(255);
    if (e)fill(0);
    else fill(255);
    rect(x, y, w, h);
    if (e)fill(255);
    else fill(0);
    if (e) {
      text(entry, x, y, w, h);
    }
  }
  String run(String val) {
    doCommon(0);
    if (!e&&le) {//edit finished
      if (entry!="") {
        val=entry;
      }
    }
    if (!e) {
      text(val, x, y, w, h);
    }
    popStyle();
    return val;
  }
  int run(int val) {
    doCommon(1);
    if (!e&&le) {//edit finished
      if (int(entry)==int(entry)&&entry!="") {
        val=int(entry);
      }
    }
    if (!e) {
      text(str(val), x, y, w, h);
    }
    popStyle();
    return val;
  }
  float run(float val) {
    doCommon(2);
    if (!e&&le) {//edit finished
      if (float(entry)==float(entry)&&entry!="") {//NaN check
        val=float(entry);
      }
    }
    if (!e) {
      text(str(val), x, y, w, h);
    }
    popStyle();
    return val;
  }
}
void keyPressed() {
  keyPressTypeBox=true;
}

boolean mInC(float x, float y, float w, float h) { //is mouse within bounds, using CENTER shape mode
  if (mouseX>x-w/2&&mouseX<x+w/2&&mouseY>y-h/2&&mouseY<y+h/2) {
    return true;
  }
  return false;
}
