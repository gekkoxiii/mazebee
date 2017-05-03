int dimension=100;
maze monMaze=new maze(dimension, 2);
int step=0;
int labyrinthe_width;
int labyrinthe_x;
int labyrinthe_y;
int sallesize;
PImage labyrinthe=new PImage();
IntList liste_salle_idx=new IntList();
int type_of_destroy=4;
int destroy_type;
float easing = 1.1;


void settings() {
  fullScreen();
  noSmooth();
  pixelDensity(displayDensity());
  //size(1200, 1200);
  //noLoop();
}
void setup() {
  background(255);
  //frameRate(200);
  monMaze.mazedraw();
  for (int i=0; i<dimension*dimension; i++) {
    liste_salle_idx.append(i);
  }
  sallesize=monMaze.getSalle(0).getSallesize();
  labyrinthe_width=dimension*sallesize;
  labyrinthe_x=(width-labyrinthe_width)/2;
  labyrinthe_y=(height-labyrinthe_width)/2;
  print("labyrinthe_width =", labyrinthe_width, "\nlabyrinthe_x =", labyrinthe_x, "\nlabyrinthe_y =", labyrinthe_y, "\n");
  destroy_type=3;
  //monMaze.setPosition(int(random(dimension*dimension)));
  //monMaze.solve();
}

void draw() {
  int rand_idx_salle;
  if (monMaze.getStatut()<2 && monMaze.getPosition()<monMaze.getDimension()*monMaze.getDimension()-1) {
    monMaze.highlight();
    monMaze.framesolve();
    fill(255, 10);
    rect(0, 0, width, height);
  }
  if (monMaze.getStatut()==2) {
    monMaze.getSalle(monMaze.getPosition()).setVisited(true);
    monMaze.getSalle(monMaze.getPosition()).setOnPath(true);
    monMaze.getSalle(monMaze.getPosition()).drawSallepath(dimension);
    monMaze.setStatut(3);
    monMaze.setSallebyX();
    monMaze.setSallebyY();
  } 
  if (monMaze.getStatut()==3) {
    switch(destroy_type) {
    case 0:
      monMaze.framedestroy();
      break;
    case 1:
      monMaze.framedestroy3();
      break;
    case 2:
      //IntList liste_salle_idx=new IntList();
      rand_idx_salle=int(random(liste_salle_idx.size()));
      if (liste_salle_idx.size()>0) {
        monMaze.framedestroy2(liste_salle_idx.get(rand_idx_salle));
        liste_salle_idx.remove(rand_idx_salle);
        //delay(100);
      } else {
        for (int i=0; i<dimension*dimension; i++) {
          liste_salle_idx.append(i);
        }
        monMaze.setStatut(4);
      }
      break;
    case 3:
      //scale(easing);
      fill(255, 10);
      rect(0, 0, width, height);
      //monMaze.mazedraw2();
      //rand_idx_salle=int(random(monMaze.getNombredeSalle()));
      //monMaze.movingsalle(easing, rand_idx_salle);
      easing=easing+easing/100;
      if (easing>3) {
        monMaze.setStatut(4);
      }
      delay(10);
      break;
    }
  }

  if (monMaze.getStatut()==4) {
    scale(1);
    easing=1.1;
    fill(255);
    rect(0, 0, width, height);
    labyrinthe_width=dimension*sallesize;
    labyrinthe_x=(width-labyrinthe_width)/2;
    labyrinthe_y=(height-labyrinthe_width)/2;
    //delay(1000);
    destroy_type=int(random(type_of_destroy));
    monMaze=new maze(dimension, 2);
    monMaze.mazedraw();
  }
}