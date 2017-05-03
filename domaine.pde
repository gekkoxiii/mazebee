class domaine {
  int domaine_id=-1;
  IntList liste_salleidx= new IntList();

  domaine(int domaine_idx) {
    this.domaine_id=domaine_idx;
  }

  int getDomaineid() {
    return(this.domaine_id);
  }

  void addSalle(int salle_id) {
    this.liste_salleidx.append(salle_id);
  }

  IntList getSalle() {
    return(liste_salleidx);
  }
}