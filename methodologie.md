<link href="_assets/image.css" rel="stylesheet">
<style>
.tooltip {
  position: relative;
  display: inline-block;
  text-decoration: none;
  padding: 10px 0;

}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 10px 10px;
  position: absolute;
  z-index: 1;
  bottom: 150%;
  left: 50%;
  margin-left: -60px;
}

.tooltip .tooltiptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: black transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}
</style>

## Méthodologie

Les courbes présentées sur le site sont issues des scénarios de modélisations ayant impacté les politiques publiques mises en place en France. Elles sont principalement issues de scénarios de modélisation de l’Institut Pasteur et de l’INSERM. 
Pour permettre une évaluation appropriée des scénarios de modélisation, seuls les scénarios dont les hypothèses sont vérifiées ont été retenus, notamment les hyopthèses portant sur les mesures mises en place. 
Afin de ne pas introduire de biais (par exemple ne prendre que les scénarios qui surestimaient la réalité, ou l’inverse), nous avons étudié les scénarios de manière exhaustive. 
Nous avons analysé :

1. toutes les modélisations issues des rapports de l'Insitut Pasteur, publiés sur <a href = "https://modelisation-covid19.pasteur.fr/">ce site</a> 
2. les modélisations cités dans les <a href = "https://solidarites-sante.gouv.fr/actualites/presse/dossiers-de-presse/article/conseil-scientifique-covid-19"> rapports du Conseil Scientifique</a>, ce qui nous à notamment mené à identifier des scénarios de l’INSERM pour janvier-février 2021
3. les modélisations de l’Imperial College pour le 1er confinement: il n’y a pas eu de modélisation spécifique à la France, mais celle d’Imperial College a été reprise par le Conseil Scientifique et a eu un impact majeur sur les politiques publiques françaises 
4. une recherche google rétrospective avec dates délimitées pour chaque mois et les mots-clés "INSERM", "Pasteur", "modélisation", "scénario". Cela a permis d'identifier des scénarios non officiellement publiés mais néanmoins cités par la presse : Institu Pasteur pour le 2ème confinement de novembre 2020, et Institut Pasteur pour le déconfinement de l'Ile-de-France en mai 2020.

## Méthodologie détaillée

La liste exhaustive des scénarios de modélisation, et de leur inclusion ou non dans l’analyse du site (avec la raison) est disponible ci-dessous. 

<details><summary><b><div class="tooltip">Modélisations de l’Institut Pasteur
</div></b></summary>
<p>
  
<ul>
  <li>29 avril 2020 : inclus (non officiellement publié mais retranscrit par la presse)</li>
  <li>25 septembre 2020 : exclu (des mesures ont été prises en septembre, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li>30 octobre 2020 : inclus (ce sont les modélisations du 2ème confinement, non publiées sur le site de l’Institut Pasteur mais retranscrites par la presse)</li>
  <li>8 février 2021 : inclus</li>
  <li>23 février 2021 : inclus</li>
  <li>29 mars 2021 : pas de scénario dans le rapport</li>
  <li>6 avril 2021 : exclu  (les courbes présentées sont un contrefactuel de l'évolution épidémique en l'absence de vaccination)</li>
  <li>26 avril 2021 : travail en cours, l’analyse est rendue complexe de par les dates de levée des mesures</li>
  <li>21 mai 2021 : exclus (apparition du variant Delta non pris en compte dans les modélisations)</li>
  <li>9 juillet 2021 : exclus (la mise en place du pass sanitaire n’était pas incluse dans les hypothèses de modélisation, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li>26 juillet 2021 : inclus (les scénarios prennent en compte la mise en place du pass)</li>
  <li>5 août 2021 : inclus (les scénarios prennent en compte la mise en place du pass sanitaire)</li>
  <li>6 septembre 2021 : pas de scénarios dans le rapport</li>
  <li>4 octobre 2021 : inclus</li>
  <li>29 novembre 2021 : exclus (apparition du variant Omicron non pris en compte dans les modélisations)</li>
  <li>2 décembre 2021 : exclus (apparition du variant Omicron non pris en compte dans les modélisations)</li>
</ul>
  

</p>
</details>


<details><summary><b><div class="tooltip">Modélisations de l’INSERM
</div></b></summary>
<p>
<ul>
  <li>modélisations de janvier-février 2021: inclues car apparaissant dans le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport du Conseil Scientifique</a> du 29 janvier 2021 suggérant l’instauration d’un confinement strict</li>
</ul>

</p>
</details>

<details><summary><b><div class="tooltip">Modélisations de l’Imperial College
</div></b></summary>
<p>
<ul>
  <li>modélisations du rapport 12: inclues car cités comme argument majeur en faveur du confinement dans le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport du Conseil Scientifique</a> du 12 mars 2020 </li>
</ul>

</p>
</details>
