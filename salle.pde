class salle {
  boolean visited=false;
  boolean occuped=false;
  boolean depart=false;
  int Sallesize=12;
  boolean absolute=false;
  float posX=-1;
  float posY=-1;
  int SalleN=-1;
  int SalleE=-1;
  int SalleS=-1;
  int SalleW=-1;
  boolean Path_to_outside=false;
  IntList Path=new IntList();
  int domaine=-1;

  salle() {
  }

  boolean isAbsolute() {
    return(this.absolute);
  }

  void setAbsolute(boolean absolute) {
    this.absolute=absolute;
  }
  int getSallesize() {
    return(this.Sallesize);
  }
  void setDepart(boolean depart) {
    this.depart=depart;
  }

  boolean isDepart() {
    return(this.depart);
  }

  void setDomaine(int domaine) {
    this.domaine=domaine;
  }

  void setOnPath(boolean OnPath) {
    this.Path_to_outside=OnPath;
  }

  boolean isOn_Path_to_outside() {
    return(this.Path_to_outside);
  }

  int getDomaine() {
    return(this.domaine);
  }

  void setVisited(boolean visited) {
    this.visited=visited;
  }

  void addPath(int salleidx) {
    this.Path.append(salleidx);
  }

  IntList getPath() {
    return(this.Path);
  }

  boolean isVisited() {
    return(this.visited);
  }

  void setOccuped(boolean occuped) {
    this.occuped=occuped;
  }

  boolean isOccuped() {
    return(this.occuped);
  }


  void setPosX(float X) {
    this.posX=X;
  }

  void setPosY(float Y) {
    this.posY=Y;
  }

  float getPosX() {
    return(this.posX);
  }

  float getPosY() {
    return(this.posY);
  }


  void setSalleN(int id) {
    this.SalleN=id;
  }

  void setSalleE(int id) {
    this.SalleE=id;
  }

  void setSalleS(int id) {
    this.SalleS=id;
  }

  void setSalleW(int id) {
    this.SalleW=id;
  }

  int getSalleN() {
    return(this.SalleN);
  }

  int getSalleE() {
    return(this.SalleE);
  }

  int getSalleS() {
    return(this.SalleS);
  }

  int getSalleW() {
    return(this.SalleW);
  }

  void drawSalle_mur(int dimension) {
    float plusX=0;
    float plusY=0;
    if (!this.isAbsolute()) {
      plusX=(width-this.Sallesize*dimension)/2;
      plusY=(height-this.Sallesize*dimension)/2;
    }
    if (!this.isAbsolute()) {
      if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
        //      stroke(231, 213, 250);
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY);
      }
      if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
        stroke(0, 0, 0);
        line((this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
      if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
      if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
    } else {
      if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
        //      stroke(231, 213, 250);
        stroke(0, 0, 0);
        line(this.posX, this.posY, this.posX+Sallesize, this.posY);
      }
      if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
        stroke(0, 0, 0);
        line(this.posX+Sallesize, this.posY, this.posX+Sallesize, this.posY+Sallesize);
      }
      if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
        stroke(0, 0, 0);
        line(this.posX, this.posY+Sallesize, this.posX+Sallesize, this.posY+Sallesize);
      }
      if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
        stroke(0, 0, 0);
        line(this.posX, this.posY, this.posX, this.posY+Sallesize);
      }
    }
  }


  void drawSalle(int dimension) {
    float plusX=0;
    float plusY=0;
    if (!this.isAbsolute()) {
      plusX=(width-this.Sallesize*dimension)/2;
      plusY=(height-this.Sallesize*dimension)/2;
    }
    color currentcolor;
    if (this.isVisited()) {
      currentcolor=color(251, 194, 76);//jaune
    } else {
      currentcolor=color(255, 255, 255);//blanc
      //currentcolor=color(86, 34, 162);//violet
    }
    if (isOn_Path_to_outside()) {
      currentcolor=color(142, 228, 105);//green
    }
    if (this.isDepart()) {
      currentcolor=color(255, 255, 255);//blanc
    }

    stroke(currentcolor);
    fill(currentcolor);
    if (!this.isAbsolute()) {
      rect(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.Sallesize, this.Sallesize);
      if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
        //      stroke(231, 213, 250);
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY);
      }
      if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
        stroke(0, 0, 0);
        line((this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
      if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
      if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
        stroke(0, 0, 0);
        line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
      }
    } else {
      if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
        //      stroke(231, 213, 250);
        stroke(0, 0, 0);
        line(this.posX, this.posY, this.posX+Sallesize, this.posY);
      }
      if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
        stroke(0, 0, 0);
        line(this.posX+Sallesize, this.posY, this.posX+Sallesize, this.posY+Sallesize);
      }
      if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
        stroke(0, 0, 0);
        line(this.posX, this.posY+Sallesize, this.posX+Sallesize, this.posY+Sallesize);
      }
      if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
        stroke(0, 0, 0);
        line(this.posX, this.posY, this.posX, this.posY+Sallesize);
      }
    }
  }


void drawSalledestroy(int dimension) {
  float plusX=0;
  float plusY=0;
  if (!this.isAbsolute()) {
    plusX=(width-this.Sallesize*dimension)/2;
    plusY=(height-this.Sallesize*dimension)/2;
  }
  color currentcolor=color(0, 0, 0);
  color currentcolor2=color(255, 255, 0);
  //if (this.isVisited()) {
  //  currentcolor=color(251, 194, 76);//jaune
  //} else {
  //  currentcolor=color(255, 255, 255);//blanc
  //  //currentcolor=color(86, 34, 162);//violet
  //}
  //if (isOn_Path_to_outside()) {
  //  currentcolor=color(142, 228, 105);//green
  //}
  //if (this.isDepart()) {
  //  currentcolor=color(255, 255, 255);//blanc
  //}

  stroke(currentcolor);
  fill(currentcolor2);
  if (!this.isAbsolute()) {
    //rect(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.Sallesize, this.Sallesize);
    if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
      //      stroke(231, 213, 250);
      stroke(0, 0, 0);
      line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY);
    }
    if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
      stroke(0, 0, 0);
      line((this.posX+1)*Sallesize+plusX, this.posY*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
    }
    if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
      stroke(0, 0, 0);
      line(this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY, (this.posX+1)*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
    }
    if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
      stroke(0, 0, 0);
      line(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.posX*Sallesize+plusX, (this.posY+1)*Sallesize+plusY);
    }
  } else {
    if (this.SalleN<0 || !this.Path.hasValue(this.SalleN)) {
      //      stroke(231, 213, 250);
      stroke(0, 0, 0);
      line(this.posX, this.posY, this.posX+Sallesize, this.posY);
    }
    if (this.SalleE<0 || !this.Path.hasValue(this.SalleE)) {
      stroke(0, 0, 0);
      line(this.posX+Sallesize, this.posY, this.posX+Sallesize, this.posY+Sallesize);
    }
    if (this.SalleS<0 || !this.Path.hasValue(this.SalleS)) {
      stroke(0, 0, 0);
      line(this.posX, this.posY+Sallesize, this.posX+Sallesize, this.posY+Sallesize);
    }
    if (this.SalleW<0 || !this.Path.hasValue(this.SalleW)) {
      stroke(0, 0, 0);
      line(this.posX, this.posY, this.posX, this.posY+Sallesize);
    }
  }
}


void drawSallepath2(int dimension) {
  float plusX=0;
  float plusY=0;
  if (!this.isAbsolute()) {
    plusX=(width-this.Sallesize*dimension)/2;
    plusY=(height-this.Sallesize*dimension)/2;
  }
  color currentcolor;
  color currentcolor2;
  if (this.isVisited()) {
    currentcolor=color(227, 158, 0);//jaune
    currentcolor2=color(255, 222, 168);//jaune
  } else {
    currentcolor=color(86, 34, 162);//violet
    currentcolor2=color(86, 34, 162);//violet
  }
  if (isOn_Path_to_outside()) {
    currentcolor=color(34, 86, 9);//green
    currentcolor2=color(225, 253, 212);//green
  }
  if (this.isDepart()) {
    currentcolor=color(0, 0, 0);//noir
    currentcolor2=color(231, 213, 250);//blanc
  }
  stroke(currentcolor);
  fill(currentcolor2);
  rect(this.posX*Sallesize+plusX+2, this.posY*Sallesize+plusY+2, this.Sallesize-4, this.Sallesize-4);
}

void drawSallepath(int dimension) {
  float plusX=0;
  float plusY=0;
  if (!this.isAbsolute()) {
    plusX=width/2-this.Sallesize/2*dimension;
    plusY=height/2-this.Sallesize/2*dimension;
  }
  color currentcolor;
  color currentcolor2;
  if (this.isVisited()) {
    currentcolor=color(227, 158, 0);//jaune
    currentcolor2=color(255, 222, 168);//jaune
  } else {
    //currentcolor=color(86, 34, 162);//violet
    //currentcolor2=color(86, 34, 162);//violet
    currentcolor=color(255, 255, 255);//violet
    currentcolor2=color(255, 255, 255);//violet
  }
  if (isOn_Path_to_outside()) {
    currentcolor=color(34, 86, 9);//green
    currentcolor2=color(225, 253, 212);//green
  }
  if (this.isDepart()) {
    currentcolor=color(0, 0, 0);//noir
    currentcolor2=color(231, 213, 250);//blanc
  }
  stroke(currentcolor);
  fill(currentcolor2);
  if (!this.isAbsolute()) {
    //fill(255,0,0);
    ellipse(this.posX*Sallesize+plusX+this.Sallesize/2, this.posY*Sallesize+plusY+this.Sallesize/2, this.Sallesize-4, this.Sallesize-4);
  } else {
    //fill(0,255,0);
    ellipse(this.posX+Sallesize/2, this.posY+Sallesize/2, this.Sallesize, this.Sallesize);
  }
}

void drawinvisible(int dimension) {
  float plusX=0;
  float plusY=0;
  if (!this.isAbsolute()) {
    plusX=(width-this.Sallesize*dimension)/2;
    plusY=(height-this.Sallesize*dimension)/2;
  }
  color currentcolor=color(255, 255, 255);
  stroke(currentcolor);
  fill(currentcolor);
  if (!this.isAbsolute()) {
    rect(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.Sallesize, this.Sallesize);
  } else {
    rect(this.posX+plusX, this.posY+plusY, this.Sallesize, this.Sallesize);
  }
}

void drawhighlighted(int dimension,int radius) {
  float plusX=0;
  float plusY=0;
  if (!this.isAbsolute()) {
    plusX=(width-this.Sallesize*dimension)/2;
    plusY=(height-this.Sallesize*dimension)/2;
  }
  color currentcolor=color(34, 86, 9);
  fill(currentcolor,20);
  noStroke();
  if (!this.isAbsolute()) {
    //rect(this.posX*Sallesize+plusX, this.posY*Sallesize+plusY, this.Sallesize, this.Sallesize);
    ellipse(this.posX*Sallesize+plusX+this.Sallesize/2, this.posY*Sallesize+plusY+this.Sallesize/2, radius, radius);
  } else {
    ellipse(this.posX+Sallesize/2, this.posY+Sallesize/2, this.Sallesize, this.Sallesize);
    //rect(this.posX+plusX, this.posY+plusY, this.Sallesize, this.Sallesize);
  }
}

void setSalleProperties(int indexofSalle, int L) {
  //salle currentSalle=listeSalle.get(indexofSalle);
  this.setDomaine(indexofSalle);
  this.setPosX(indexofSalle%L);
  this.setPosY(int (indexofSalle/L));
  if (this.posX+1==L) {
    //print ("pour salle ", indexofSalle, "pas de salle est.\n");
  } else {
    this.setSalleE(indexofSalle+1);
  }
  if (this.posX-1==-1) {
    //print ("pour salle ", indexofSalle, "pas de salle ouest.\n");
  } else {
    this.setSalleW(indexofSalle-1);
  }
  if (indexofSalle-L<0) {
    //print ("pour salle ", indexofSalle, "pas de salle nord.\n");
  } else {
    this.setSalleN(indexofSalle-L);
  }
  if (indexofSalle+L>L*L-1) {
    //print ("pour salle ", indexofSalle, "pas de salle sud.\n");
  } else {
    this.setSalleS(indexofSalle+L);
  }
}
}
