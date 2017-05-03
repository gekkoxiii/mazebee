class maze {

  ArrayList<salle> listeSalle = new ArrayList<salle>();
  IntList salle_unvisited = new IntList ();
  int L;
  int methode;
  int position;
  int depart;
  int highlighted;
  IntList journey=new IntList();
  int statut=-1;//-1=unset, 0=created, 1=solving, 2=solved, 3=need to be reset, 4=get a new one
  ArrayList<domaine> sallebyX=new ArrayList<domaine>();
  ArrayList<domaine> sallebyY=new ArrayList<domaine>();

  maze(int L, int methode) {
    this.L=L;
    this.methode=methode;
    for (int i=0; i<L*L; i++) {
      this.sallecreat();
      this.listeSalle.get(i).setSalleProperties(i, L);
    }
    switch (this.methode) {
    case 1:
      this.createpath1();
      break;
    case 2:
      this.createpath2();
      break;
    }
    this.setPosition(int(random(L*L)));
    //this.setPosition(0);
    this.depart=this.getPosition();
    listeSalle.get(position).setDepart(true);
    this.highlighted=this.depart;
    this.setStatut(0);
  }

  int getNombredeSalle() {
    return(this.listeSalle.size());
  }
  void setSallebyX () {
    for (int i=0; i<L; i++) {
      sallebyX.add(new domaine(i));
    }
    for (int i=0; i<L*L; i++) {
      sallebyX.get(i%L).addSalle(i);
    }
  }

  void setSallebyY () {
    for (int i=0; i<L; i++) {
      sallebyY.add(new domaine(i));
    }
    for (int i=0; i<L*L; i++) {
      sallebyY.get(int(i/L)).addSalle(i);
    }
  }

  int getStatut() {
    return(this.statut);
  }

  void setStatut (int statut) {
    this.statut=statut;
  }

  int getDimension() {
    return(this.L);
  }

  void sallecreat() {
    this.listeSalle.add(new salle());
  }

  salle getSalle(int salle_idx) {
    return(listeSalle.get(salle_idx));
  }


  int getPosition() {
    return(this.position);
  }

  void setPosition(int position) {
    this.position=position;
    listeSalle.get(position).setOccuped(true);
    listeSalle.get(position).setVisited(true);
  }

  void mazedraw() {
    for (int i=0; i<L*L; i++) {
      salle currentSalle =listeSalle.get(i);
      currentSalle.drawSalle(this.L);
      currentSalle.drawSallepath(this.L);
    }
  }

  void setliste_unvisited_salle() {
    salle_unvisited.clear();
    for (int i=0; i<L*L; i++) {
      if (!listeSalle.get(i).isVisited()) {
        salle_unvisited.append(i);
      }
    }
  }

  void createpath1 () {
    setliste_unvisited_salle();
    while (salle_unvisited.size()>0) {
      int idx_salle_depart_domaine=int(random(salle_unvisited.size()));
      //print ("Liste des salles non visitées : ", salle_unvisited, "\n");
      //print ("Démarrage en salle: ", salle_unvisited.get(idx_salle_depart_domaine), "\n");
      createdompath(salle_unvisited.get(idx_salle_depart_domaine));
      setliste_unvisited_salle();
    }
    for (int i=0; i<L*L; i++) {
      this.listeSalle.get(i).setVisited(false);
    }
    //print ("Chemin créé\n");
  }

  void createdompath(int salle_depart) {
    //    IntList direction_possible = direction_possible(salle_depart);
    int next_salleidx;
    listeSalle.get(salle_depart).setVisited(true);
    while (direction_possible(salle_depart).size()>0) {
      IntList direction_possible = direction_possible(salle_depart);
      next_salleidx=direction_possible.get(int(random(direction_possible.size())));
      listeSalle.get(salle_depart).addPath(next_salleidx);
      listeSalle.get(next_salleidx).addPath(salle_depart);
      //print("Next salle : ", next_salleidx, "\n");
      createdompath(next_salleidx);
    }
  }


  IntList direction_possible(int idx_salle) {
    IntList direction_possible = new IntList();
    if (listeSalle.get(idx_salle).getSalleN()>=0 && !listeSalle.get(listeSalle.get(idx_salle).getSalleN()).isVisited()) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleN());
    }
    if (listeSalle.get(idx_salle).getSalleE()>=0 && !listeSalle.get(listeSalle.get(idx_salle).getSalleE()).isVisited()) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleE());
    }
    if (listeSalle.get(idx_salle).getSalleS()>=0 && !listeSalle.get(listeSalle.get(idx_salle).getSalleS()).isVisited()) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleS());
    }
    if (listeSalle.get(idx_salle).getSalleW()>=0 && !listeSalle.get(listeSalle.get(idx_salle).getSalleW()).isVisited()) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleW());
    }
    //print("direction_possible :", direction_possible, "\n");
    return(direction_possible);
  }

  IntList direction_possible2(int idx_salle, int domaine) {
    IntList direction_possible = new IntList();
    if (listeSalle.get(idx_salle).getSalleN()>=0 && listeSalle.get(listeSalle.get(idx_salle).getSalleN()).getDomaine()!=domaine) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleN());
    }
    if (listeSalle.get(idx_salle).getSalleE()>=0 && listeSalle.get(listeSalle.get(idx_salle).getSalleE()).getDomaine()!=domaine) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleE());
    }
    if (listeSalle.get(idx_salle).getSalleS()>=0 && listeSalle.get(listeSalle.get(idx_salle).getSalleS()).getDomaine()!=domaine) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleS());
    }
    if (listeSalle.get(idx_salle).getSalleW()>=0 && listeSalle.get(listeSalle.get(idx_salle).getSalleW()).getDomaine()!=domaine) {
      direction_possible.append(listeSalle.get(idx_salle).getSalleW());
    }
    //print("direction_possible de la salle ", idx_salle, " sont :", direction_possible, "\n");
    return(direction_possible);
  }


  void createpath2() {
    ArrayList<domaine> liste_domaine =new ArrayList<domaine>();
    int selected_salle=-1;
    for (int i=0; i<L*L; i++) {
      liste_domaine.add(new domaine(i));
      liste_domaine.get(i).addSalle(i);
    }
    //for (int i=0; i<L*L; i++) {
    //  print ("Liste domaine ", i, " : ", liste_domaine.get(i).getSalle(), "\n");
    //}
    while (liste_domaine.size()>1) {
      int min_domaineid=-1;
      int max_domaineid=-1;
      int min_domaineidx=-1;
      int max_domaineidx=-1;
      int random_domaine_idx=int(random(liste_domaine.size()));
      //int random_domaine=liste_domaine.get(random_domaine_idx).getDomaineid();
      IntList copy_liste_salle_in_domaine=new IntList();
      int random_salle_indomaine_idx=-1;//int(random(liste_domaine.get(random_domaine_idx).getSalle().size()));
      int salle_id=-1;
      IntList direction_possible=new IntList();
      //print ("Open path dans le domaine : ", random_domaine, " contenant les salle : ", liste_domaine.get(random_domaine_idx).getSalle(), "\n");
      for (int i=0; i<liste_domaine.get(random_domaine_idx).getSalle().size(); i++) {
        copy_liste_salle_in_domaine.append(liste_domaine.get(random_domaine_idx).getSalle().get(i));
      }
      while (direction_possible.size()==0) {
        //random_domaine_idx=int(random(liste_domaine.size()));
        //random_domaine=liste_domaine.get(random_domaine_idx).getDomaineid();
        //random_salle_indomaine_idx=int(random(liste_domaine.get(random_domaine_idx).getSalle().size()));
        random_salle_indomaine_idx=int(random(copy_liste_salle_in_domaine.size()));
        //print ("random_salle_indomaine_idx", random_salle_indomaine_idx, "\n");
        salle_id=copy_liste_salle_in_domaine.get(random_salle_indomaine_idx);
        //print ("depuis la salle : ", salle_id, "\n");
        direction_possible=direction_possible2(salle_id, listeSalle.get(salle_id).getDomaine());
        copy_liste_salle_in_domaine.remove(random_salle_indomaine_idx);
        //print ("Liste des salles du domaine : ", copy_liste_salle_in_domaine, "\n");
      }
      selected_salle=direction_possible.get(int(random(direction_possible.size())));
      //print("et vers salle : ", selected_salle, "\n");
      min_domaineid=min(listeSalle.get(salle_id).getDomaine(), listeSalle.get(selected_salle).getDomaine());
      max_domaineid=max(listeSalle.get(salle_id).getDomaine(), listeSalle.get(selected_salle).getDomaine());
      for (int i=0; i<liste_domaine.size(); i++) {
        if (liste_domaine.get(i).getDomaineid()==min_domaineid) {
          min_domaineidx=i;
        }
        if (liste_domaine.get(i).getDomaineid()==max_domaineid) {
          max_domaineidx=i;
        }
      }
      //print ("domaine aggrégé en : ", min_domaineid, "\n");
      listeSalle.get(salle_id).addPath(selected_salle);
      listeSalle.get(selected_salle).addPath(salle_id);
      for (int i=0; i<liste_domaine.get(max_domaineidx).getSalle().size(); i++) {
        listeSalle.get(liste_domaine.get(max_domaineidx).getSalle().get(i)).setDomaine(min_domaineid);
        liste_domaine.get(min_domaineidx).addSalle(liste_domaine.get(max_domaineidx).getSalle().get(i));
      }
      liste_domaine.remove(max_domaineidx);
    }
    //print ("Chemin terminé\n");
  }

  IntList where_to_go (int position) {
    IntList couldgoto=new IntList();
    for (int i=0; i<listeSalle.get(position).getPath().size(); i++) {
      if (!listeSalle.get(listeSalle.get(position).getPath().get(i)).isVisited()) {
        couldgoto.append(listeSalle.get(position).getPath().get(i));
      }
    }
    return(couldgoto);
  }

  void solve() {
    IntList moves=new IntList();
    IntList journey= new IntList();
    int next_step;
    //print("Position de départ :", this.position, "\n");
    listeSalle.get(this.position).isOn_Path_to_outside();
    while (this.position!=listeSalle.size()-1) {
      moves=this.where_to_go(this.position);
      if (moves.size()>0) {
        journey.append(this.position);
        next_step=moves.get(int(random(moves.size())));
        //print("position :", this.position, "\n");
        //print("journey : ", journey, "\n");
        //print("liste des déplacements possibles : ", moves, "\n");
        //print("nextstep : ", next_step, "\n");
        listeSalle.get(this.position).setOnPath(true);
      } else {
        listeSalle.get(this.position).setOnPath(false);
        journey.append(this.position);
        //listeSalle.get(this.position).isOn_Path_to_outside();
        next_step=journey.get(journey.size()-2);
        //print("position :", this.position, "\n");
        //print("journey : ", journey, "\n");
        //print("liste des déplacements possibles : ", moves, "so go back!\n");
        //print("nextstep : ", next_step, "\n");
        //listeSalle.get(this.position).isOn_Path_to_outside();
        journey.remove(journey.size()-1);
        journey.remove(journey.size()-1);
      }
      this.setPosition(next_step);
    }
    listeSalle.get(this.position).setOnPath(true);
    this.mazedraw();
  }

  void framesolve() {
    IntList moves=new IntList();
    //    IntList journey= new IntList();
    int next_step;
    moves=this.where_to_go(this.position);
    if (moves.size()>0) {
      journey.append(this.position);
      next_step=moves.get(int(random(moves.size())));
      //print("position :", this.position, "\n");
      //print("journey : ", journey, "\n");
      //print("liste des déplacements possibles : ", moves, "\n");
      //print("nextstep : ", next_step, "\n");
      listeSalle.get(this.position).setOnPath(true);
    } else if (this.position!=this.L*this.L-1) {
      listeSalle.get(this.position).setOnPath(false);
      journey.append(this.position);
      //listeSalle.get(this.position).isOn_Path_to_outside();
      next_step=journey.get(journey.size()-2);
      //print("position :", this.position, "\n");
      //print("journey : ", journey, "\n");
      //print("liste des déplacements possibles : ", moves, "so go back!\n");
      //print("nextstep : ", next_step, "\n");
      //listeSalle.get(this.position).isOn_Path_to_outside();
      journey.remove(journey.size()-1);
      journey.remove(journey.size()-1);
    } else {
      //print("position :", this.position, " JOB DONE!!!!\n");
      listeSalle.get(this.position).drawSallepath(this.L);
      next_step=this.L*this.L-1;
    }       
    listeSalle.get(this.position).drawSallepath(this.L);
    listeSalle.get(this.depart).drawSallepath(this.L);

    for (int i=0; i<L*L; i++) {
      listeSalle.get(i).drawSalle_mur(this.L);
      if (listeSalle.get(i).isOn_Path_to_outside()) {
        listeSalle.get(i).drawSallepath(this.L);
      }
    }
    this.setPosition(next_step);
    if (next_step==this.L*this.L-1) {
      listeSalle.get(next_step).setOnPath(true);
      listeSalle.get(next_step).drawSallepath(next_step);
      this.setStatut(2);
    }
  }

  void framedestroy() {
    if (sallebyX.size()>0) {
      int randomXidx=int (random(sallebyX.size()));
      listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleN()!=-1) {
        int salleN=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleN();
        listeSalle.get(salleN).setSalleS(-1);
        listeSalle.get(salleN).drawSalledestroy(this.L);
        //listeSalle.get(salleN).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleE()!=-1) {
        int salleE=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleE();
        listeSalle.get(salleE).setSalleW(-1);
        listeSalle.get(salleE).drawSalledestroy(this.L);
        //listeSalle.get(salleE).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleS()!=-1) {
        int salleS=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleS();
        listeSalle.get(salleS).setSalleN(-1);
        listeSalle.get(salleS).drawSalledestroy(this.L);
        //listeSalle.get(salleS).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleW()!=-1) {
        int salleW=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(0)).getSalleW();
        listeSalle.get(salleW).setSalleE(-1);
        listeSalle.get(salleW).drawSalledestroy(this.L);
        //listeSalle.get(salleW).drawSallepath(this.L);
      }
      //listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      sallebyX.get(randomXidx).getSalle().remove(0);
      if (sallebyX.get(randomXidx).getSalle().size()==0) {
        sallebyX.remove(randomXidx);
      }
      randomXidx=int (random(sallebyX.size()));
      int lastsalleidx=sallebyX.get(randomXidx).getSalle().size()-1;
      listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).drawinvisible(this.L);
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleN()!=-1) {
        int salleN=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleN();
        listeSalle.get(salleN).setSalleS(-1);
        listeSalle.get(salleN).drawSalledestroy(this.L);
        //listeSalle.get(salleN).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleE()!=-1) {
        int salleE=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleE();
        listeSalle.get(salleE).setSalleW(-1);
        listeSalle.get(salleE).drawSalledestroy(this.L);
        //listeSalle.get(salleE).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleS()!=-1) {
        int salleS=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleS();
        listeSalle.get(salleS).setSalleN(-1);
        listeSalle.get(salleS).drawSalledestroy(this.L);
        //listeSalle.get(salleS).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleW()!=-1) {
        int salleW=listeSalle.get(sallebyX.get(randomXidx).getSalle().get(lastsalleidx)).getSalleW();
        listeSalle.get(salleW).setSalleE(-1);
        listeSalle.get(salleW).drawSalledestroy(this.L);
        //listeSalle.get(salleW).drawSallepath(this.L);
      }
      //listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      sallebyX.get(randomXidx).getSalle().remove(lastsalleidx);
      if (sallebyX.get(randomXidx).getSalle().size()==0) {
        sallebyX.remove(randomXidx);
      }
    } else {
      this.setStatut(4);
    }
  }

  void framedestroy2(int rand_idx_salle) {
    //rand_idx_salle=int(random(listeSalle.size()));
    listeSalle.get(rand_idx_salle).drawinvisible(this.L);
    if (listeSalle.get(rand_idx_salle).getSalleN()!=-1) {
      int salleN=listeSalle.get(rand_idx_salle).getSalleN();
      listeSalle.get(salleN).setSalleS(-1);
      listeSalle.get(salleN).drawSalledestroy(this.L);
      //listeSalle.get(salleN).drawSallepath(this.L);
    }
    if (listeSalle.get(rand_idx_salle).getSalleE()!=-1) {
      int salleE=listeSalle.get(rand_idx_salle).getSalleE();
      listeSalle.get(salleE).setSalleW(-1);
      listeSalle.get(salleE).drawSalledestroy(this.L);
      //listeSalle.get(salleE).drawSallepath(this.L);
    }
    if (listeSalle.get(rand_idx_salle).getSalleS()!=-1) {
      int salleS=listeSalle.get(rand_idx_salle).getSalleS();
      listeSalle.get(salleS).setSalleN(-1);
      listeSalle.get(salleS).drawSalledestroy(this.L);
      //listeSalle.get(salleS).drawSallepath(this.L);
    }
    if (listeSalle.get(rand_idx_salle).getSalleW()!=-1) {
      int salleW=listeSalle.get(rand_idx_salle).getSalleW();
      listeSalle.get(salleW).setSalleE(-1);
      listeSalle.get(salleW).drawSalledestroy(this.L);
      //listeSalle.get(salleW).drawSallepath(this.L);
    }
  }

  void framedestroy3() {
    if (sallebyY.size()>0) {
      int randomXidx=int (random(sallebyY.size()));
      listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleN()!=-1) {
        int salleN=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleN();
        listeSalle.get(salleN).setSalleS(-1);
        listeSalle.get(salleN).drawSalledestroy(this.L);
        //listeSalle.get(salleN).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleE()!=-1) {
        int salleE=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleE();
        listeSalle.get(salleE).setSalleW(-1);
        listeSalle.get(salleE).drawSalledestroy(this.L);
        //listeSalle.get(salleE).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleS()!=-1) {
        int salleS=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleS();
        listeSalle.get(salleS).setSalleN(-1);
        listeSalle.get(salleS).drawSalledestroy(this.L);
        //listeSalle.get(salleS).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleW()!=-1) {
        int salleW=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).getSalleW();
        listeSalle.get(salleW).setSalleE(-1);
        listeSalle.get(salleW).drawSalledestroy(this.L);
        //listeSalle.get(salleW).drawSallepath(this.L);
      }
      //listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      sallebyY.get(randomXidx).getSalle().remove(0);
      if (sallebyY.get(randomXidx).getSalle().size()==0) {
        sallebyY.remove(randomXidx);
      }
      randomXidx=int (random(sallebyY.size()));
      int lastsalleidx=sallebyY.get(randomXidx).getSalle().size()-1;
      listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).drawinvisible(this.L);
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleN()!=-1) {
        int salleN=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleN();
        listeSalle.get(salleN).setSalleS(-1);
        listeSalle.get(salleN).drawSalledestroy(this.L);
        //listeSalle.get(salleN).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleE()!=-1) {
        int salleE=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleE();
        listeSalle.get(salleE).setSalleW(-1);
        listeSalle.get(salleE).drawSalledestroy(this.L);
        //listeSalle.get(salleE).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleS()!=-1) {
        int salleS=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleS();
        listeSalle.get(salleS).setSalleN(-1);
        listeSalle.get(salleS).drawSalledestroy(this.L);
        //listeSalle.get(salleS).drawSallepath(this.L);
      }
      if (listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleW()!=-1) {
        int salleW=listeSalle.get(sallebyY.get(randomXidx).getSalle().get(lastsalleidx)).getSalleW();
        listeSalle.get(salleW).setSalleE(-1);
        listeSalle.get(salleW).drawSalledestroy(this.L);
        //listeSalle.get(salleW).drawSallepath(this.L);
      }
      //listeSalle.get(sallebyY.get(randomXidx).getSalle().get(0)).drawinvisible(this.L);
      sallebyY.get(randomXidx).getSalle().remove(lastsalleidx);
      if (sallebyY.get(randomXidx).getSalle().size()==0) {
        sallebyY.remove(randomXidx);
      }
    } else {
      this.setStatut(4);
    }
  }

  void movingsalle(float scale, int salle_idx) {
    float X=this.listeSalle.get(salle_idx).getPosX();
    float Y=this.listeSalle.get(salle_idx).getPosY();
    scale(scale);
    listeSalle.get(salle_idx).drawinvisible(this.L);
    if (!this.listeSalle.get(salle_idx).isAbsolute()) {
      int sallesize=this.listeSalle.get(salle_idx).getSallesize();
      X=sallesize*X+width/2;
      Y=sallesize*Y+height/2;
      this.listeSalle.get(salle_idx).setPosX(X);
      this.listeSalle.get(salle_idx).setPosY(Y);
      this.listeSalle.get(salle_idx).setAbsolute(true);
    }
    X=random(width);
    Y=random(height);
    this.listeSalle.get(salle_idx).setPosX(X);
    this.listeSalle.get(salle_idx).setPosY(Y);
    listeSalle.get(salle_idx).drawinvisible(this.L);
    if (listeSalle.get(salle_idx).getSalleN()!=-1) {
      int salleN=listeSalle.get(salle_idx).getSalleN();
      listeSalle.get(salle_idx).setSalleN(-1);
      listeSalle.get(salleN).setSalleS(-1);
      listeSalle.get(salleN).drawSalledestroy(this.L);
      //listeSalle.get(salleN).drawSallepath(this.L);
    }
    if (listeSalle.get(salle_idx).getSalleE()!=-1) {
      int salleE=listeSalle.get(salle_idx).getSalleE();
      listeSalle.get(salle_idx).setSalleE(-1);
      listeSalle.get(salleE).setSalleW(-1);
      listeSalle.get(salleE).drawSalledestroy(this.L);
      //listeSalle.get(salleE).drawSallepath(this.L);
    }
    if (listeSalle.get(salle_idx).getSalleS()!=-1) {
      int salleS=listeSalle.get(salle_idx).getSalleS();
      listeSalle.get(salle_idx).setSalleS(-1);
      listeSalle.get(salleS).setSalleN(-1);
      listeSalle.get(salleS).drawSalledestroy(this.L);
      //listeSalle.get(salleS).drawSallepath(this.L);
    }
    if (listeSalle.get(salle_idx).getSalleW()!=-1) {
      int salleW=listeSalle.get(salle_idx).getSalleW();
      listeSalle.get(salle_idx).setSalleW(-1);
      listeSalle.get(salleW).setSalleE(-1);
      listeSalle.get(salleW).drawSalledestroy(this.L);
      //listeSalle.get(salleW).drawSallepath(this.L);
    }
    //listeSalle.get(salle_idx).drawSalledestroy(this.L);
    listeSalle.get(salle_idx).drawSallepath(this.L);
  }

  void mazedraw2() {
    for (int i=0; i<L*L; i++) {
      salle currentSalle =listeSalle.get(i);
      currentSalle.drawSalledestroy(this.L);
      currentSalle.drawSallepath(this.L);
    }
  }

  void highlight() {
    int sallesize=listeSalle.get(0).getSallesize();
    int radius=sallesize*2;
    int count=0;
    for (int i=this.journey.size(); i>0; i--) {
      listeSalle.get(journey.get(i-1)).drawhighlighted(this.L, radius);
      if (radius>sallesize-2) {
        radius--;
      }
      if (count>9) {
        continue;
      }
    }
    if (journey.size()-10>0) {
      //listeSalle.get(journey.get(journey.size()-10)).drawinvisible(this.L);
      listeSalle.get(journey.get(journey.size()-10)).drawSallepath(this.L);
    }
  }
}