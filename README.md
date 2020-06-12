<h1>Jupyter Notebook Docker Swarm</h1>

<h3> Πανεπιστήμιο Δυτικής Αττικής </h3>
<h3> Μηχανικών Πληροφορικής και Υπολογιστών </h3>
<h3> Υπολογιστική Νέφους και Υπηρεσίες </h3>

[Docker Hub Image](https://hub.docker.com/repository/docker/xarhsasi/jupyter-notebook-kit)

**_Ομάδα :_**

* Χαράλαμπος Ασημακόπουλος, cs141098
* Ιωάννα Βασιλείου, cs141190
* Ακριβή Παπαγεωργίου, cs141026
* Φανερωμένη Τηλιακού, cs141199

**_Περίληψη_**

Ο σκοπός της εργασίας μας είναι να παρέχουμε τη δυνατότητα σε κάποιον που δεν έχει "ισχυρό υπολογιστή" να εκτελεί οποιάδηποτε γλώσσα προγραμματισμού. Η εφαρμογή βασίζεται στο περιβάλλον Jupyter, όπου είναι μία real time πλατφόρμα. Οι γλώσσες που υποστηρίζει είναι Java, PHP, Python 3, Python 3.7, R, Matlab, NodeJS. Επίσης, δημιουργήθηκαν τα εξής αρχεία: *_Dockerfile_*, *_docker-compose.yaml_* το *_swarm και gluster_*.

**_Εικόνα_**

* [Docker Hub Image](https://hub.docker.com/repository/docker/xarhsasi/jupyter-notebook-kit)

**_Βήματα Εγκατάστασης_**

*Δημιουργία Εικόνας (Προαιρετικό)**

```
make build_dockerfile
```

*Εκτέλεση Εικόνας (Προαιρετικό)**

```
make run_dockerfile
```

Τα παραπάνω δύο βήματα είναι προαιρετικά διότι κατά την δημιουργία του σμήνους οι εικόνες θα εγκαταστηθούν αυτόματα απο το Docker hub.

*Εκτέλεση & Εγκατάσταση Σμήνους**

```
make
```

*_Σημείωση_*
Κατά την εγκατάσταση μέσω του αρχείου Makefile γίνεται εγκατάσταση του manager κόμβου και εμφανίζεται το κλειδί του worker όπου και το σκριπτ περιμένει μέχρις ότου ενταχθούν όλοι οι επιθυμητοί κόμβοι στο σμήνος. 
Επίσης γίνεται και εγκατάσταση του glusterfs στον manager, και σε έναν worker, σε περίπτωση που είναι περισσότεροι οι workers τότε εκτελέστε το bash script:
```
./gluster-worker-install.sh
```
όπου θα σας ζητηθούν διαπιστευτήρια για την απομακρυσμένη σύνδεση με τον server του worker.

**_Τεχνολογίες_**

* [Docker](https://www.docker.com/)
* [Docker Swarm](https://docs.docker.com/engine/swarm/)
* [Docker Hub](https://hub.docker.com/)

**_Versioning_**

We use [github](https://github.com/) for versioning.

**_Συγγραφείς_**

* **Asimakopoulos Charalampos** - *Initial work* - [HarrysAsi](https://github.com/HarrysAsi)
* **Tiliakou Fanerwmenh** - *Initial work* - [FaniTiliakou](https://github.com/fani-tiliakou)
* **Papagewrgiou Akrivi** - *Initial work* - [ViviPap](https://github.com/vivipap)
* **Vasileiou Iwanna** - *Initial work* - [JoannaVasileiou](https://github.com/JoannaVasileiou)


