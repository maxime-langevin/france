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

Les courbes présentées sur le site sont issues des scénarios de modélisations ayant impactés les politiques publiques mises en place en France. Elles sont principalement issues de scénarios de modélisation de l’Institut Pasteur et de l’INSERM. 
Pour permettre une évaluation appropriée des scénarios de modélisation, seuls les scénarios de modélisation prenant en compte les mesures en place au moment des prédictions ont été étudiés. 
Afin de ne pas introduire de biais (par exemple ne prendre que les scénarios qui surestimaient la réalité, ou l’inverse), nous avons étudié les scénarios de manière exhaustive. 
Nous avons extrait:

1. toutes les modélisations en ligne publiés par l’Institut Pasteur 
2. les modélisations cités dans les rapport du Conseil Scientifique, ce qui nous à notamment mené à identifier des modélisations de l’INSERM
3. les modélisations de l’Imperial College pour le 1er confinement: il n’y a pas eu de modélisations spécifiques à la France, mais celle d’Imperial College ont été reprises par le Conseil Scientifique et ont eu un impact majeur sur les politiques publiques françaises 
4. une recherche google avec dates délimitées et mots-clés ("INSERM" et "Pasteur" "modélisations" "scénarios") des citations des scénarios de modélisation par la presse à permis d’identifier certains scénarios de modélisation qui n’avaient pas été publiés en ligne (notamment sur le 2ème confinement)

## Méthodologie détaillée

La liste exhaustive des scénarios de modélisation, et de leur inclusion ou non dans l’analyse du site (avec la raison) est disponible ci-dessous. 

<details><summary><b><div class="tooltip">Modélisations de l’Institut Pasteur
</div></b></summary>
<p>
  
<ul>
  <li>25 septembre 2020 : exclu (des mesures ont été prises en septembre, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li>30 octobre 2020 : inclus (ce sont les modélisations du 2ème confinement, pas publiée sur le site de l’Institut Pasteur mais retranscrites par la presse)</li>
  <li>8 février 2021 : inclus</li>
  <li>23 février 2021 : inclus</li>
  <li>29 mars 2021 : pas de projections</li>
  <li>6 avril 2021 : Travail en cours, l’analyse est rendue complexe de par la levée des mesures</li>
  <li>26 avril 2021 : Travail en cours, l’analyse est rendue complexe de par la levée des mesures</li>
  <li>21 mai 2021 : exclus (apparition du variant Delta non pris en compte dans les modélisations)</li>
  <li>9 juillet 2021 : exclus (les scénarios ayant entraîné la mise en place du pass sanitaire qui n’était pas inclus dans les hypothèses de modélisation, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li>26 juillet 2021 : inclus (les scénarios prennent en compte la mise en place du pass)</li>
  <li>5 août 2021 : inclus (les scénarios prennent en compte la mise en place du pass sanitaire)</li>
  <li>6 septembre 2021 : pas de scénarios</li>
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

<details><summary><b><div class="tooltip">Modélisations de l’INSERM
</div></b></summary>
<p>
<ul>
  <li>modélisations du rapport 12: inclues car cités comme argument majeur en faveur du confinement dans le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport du Conseil Scientifique</a> du 12 mars 2020 </li>
</ul>

</p>
</details>
