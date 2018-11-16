

## Orchestre
### Démonstration
<img  src="https://i.imgur.com/Wb0MZAa.jpg" alt="drawing" width="400" height="200"/>

### Histoire
Etant atteint de la synesthésie, Bruno perçoit la musique avec une disposition spatiale particulière. Passionné d'opéra depuis tout petit il passe beaucoup de temps dans les opéras, petit à petit il prit l'habitude de visualiser toutes les musiques qu'il entend dans sa tête sous une forme d'orchestre ce qui lui permet de se sentir "chez lui" et d'être rassuré de manière immédiate. C'est donc ce que veut transmettre Bruno à travers cette scène sortie tout droit de sa tête.

### Fonctionnement de la scene

La scène est une représentation d'un orchestre. On peut apercevoir un chef orchestre se mouvoir en fonction de la musique et d'orchestrer les autres musiciens de gauche à droite, du grave à l'aigu.

### Probleme et resolution
- Conception des musiciens
  - Problème : Mouvoir les "musiciens" en fonction de si la musique est aigu ou grave
  - Résolution : Activation des musiciens selon le chef d'orchestre. Grossissement des musiciens selon le volume de la musique
- Conception du chef d'orchestre
  - Problème : Pointer les bons musiciens au bon moment
  - Résolution : Trait qui part du chef d'orchestre et qui va vers les musiciens qui doivent s'activer.

## Scene Leaf
<img  src="https://i.imgur.com/U1pOpJg.jpg" alt="drawing" width="400" height="200"/>

 ### Histoire de la scene
   Chacun a pu être émue des couleurs que la nature nous donne en un temps d'automne. Ici, la musique produit du vent qui pousse ces feuilles de différentes couleurs. Bruno voit ici un retour vers la nature. Car, dans la nature , la vrai, on ne peut être connecté à la société d'aujourd'hui ,le calme y est.


 ### Fonctionnement de la scene  
 Pour lancer la scène Leaf vous devez dans un premier temps, choisir une musique. Grace à la lecture de cette musique, nous allons pouvoir effectuer des calculs sur l'amplitude du son, les basses, les aiguës etc ... 
 Grâce à une règle de trois, chacun de ces paramètre vont nous donner la force X et Y du vent. Cette force donnera une accélération à la feuille ( a = ax + ay équation de physique).Chaque feuille ont une couleur et chaque couleur représentent les bases , les aigues et le milieux. Le vent et l'accélération peuvent être simuler grâce à la fonction noise. Puis une règle de trois (fonction map) entre cette    fonction et la force du vent trouver avec la musique donnera une accélération a cette feuille. De plus, quelques feuilles seront en       rotation. Nous pouvons aussi simuler la poussière que le vent peut faire grâce au ligne qui accompagne cette feuille.

 ### Probleme et solution.
  - Le premier problème que nous avons rencontré fut comment faire pour avoir la sensation d'avoir des feuilles pousser par le vent. La solution à ce problème fut l'utilisation e particule. Les particules ici, sont les feuilles, et le vent est l'accélération de ces particules. 
  - Le deuxième problème, fut de savoir comment simuler le vent. La meilleure chose à faire et d'utiliser la fonction noise, et de faire une règle de trois entre ce que renvoient la fonction noise et ce que nous renvois les résultats de la fft de la music. 
  - Le troisième problème fut la simulation des traits de poussière fait par le vent. Nous avons donc utilisé une liste qui garde les positions de la feuille au fils de son emplacement et d'afficher plusieurs petite ligne avec différente opacités.
