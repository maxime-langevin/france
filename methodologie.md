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

## <span style="color:black">Méthodologie</span>

Les courbes présentées sur le site sont issues des scénarios de modélisations ayant impacté les politiques publiques mises en place en France. Elles sont principalement issues de scénarios de modélisation de l’Institut Pasteur et de l’INSERM. 
Pour permettre une évaluation appropriée des scénarios de modélisation, seuls les scénarios dont les hypothèses sont vérifiées ont été retenus, notamment les hyopthèses portant sur les mesures mises en place. 
Afin de ne pas introduire de biais (par exemple ne prendre que les scénarios qui surestimaient la réalité, ou l’inverse), nous avons étudié les scénarios de manière exhaustive. 
Nous avons analysé :

1. toutes les modélisations issues des rapports de l'Insitut Pasteur, publiés sur <a href = "https://modelisation-covid19.pasteur.fr/">leur page web</a> 
2. les modélisations cités dans les <a href = "https://solidarites-sante.gouv.fr/actualites/presse/dossiers-de-presse/article/conseil-scientifique-covid-19"> rapports du Conseil Scientifique</a>, ce qui nous à notamment mené à identifier des scénarios de l’INSERM pour janvier-février 2021
3. les modélisations de l’Imperial College pour le 1er confinement: il n’y a pas eu de modélisation spécifique à la France, mais celle d’Imperial College a été reprise par le Conseil Scientifique et a eu un impact majeur sur les politiques publiques françaises 
4. une recherche google rétrospective avec dates délimitées pour chaque mois et les mots-clés "INSERM", "Pasteur", "modélisation", "scénario". Cela a permis d'identifier des scénarios non officiellement publiés mais néanmoins cités par la presse : Institut Pasteur pour le <a href = "https://www.lesechos.fr/economie-france/social/covid-la-decrue-dans-les-services-de-reanimation-esperee-en-france-dans-une-dizaine-de-jours-1261656">2ème confinement de novembre 2020</a>, et Institut Pasteur pour le <a href = "https://www.lesechos.fr/idees-debats/editos-analyses/pourquoi-philippe-a-douche-les-francais-1199309">déconfinement de l'Ile-de-France en mai 2020</a>.

## <span style="color:black">Méthodologie détaillée</span>

La liste exhaustive des scénarios de modélisation, et de leur inclusion ou non dans l’analyse du site (avec la raison) est disponible ci-dessous, ainsi que les liens renvoyant vers les rapports en question.

<details><summary><b><div class="tooltip">Modélisations de l’Institut Pasteur
</div></b></summary>
<p>
  
<ul>
  <li><a href = "https://www.lesechos.fr/idees-debats/editos-analyses/pourquoi-philippe-a-douche-les-francais-1199309">29 avril 2020</a> : inclus (non officiellement publié mais retranscrit par la presse)</li>
  <li><a href = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiKi_Kpje71AhUBzhoKHc1SCagQFnoECAQQAQ&url=https%3A%2F%2Fwww.sdbio.eu%2Fimages%2Facymailing%2FSimulations%2520Institut%2520Pasteur%252025%252009%25202020.pdf&usg=AOvVaw1lVRUxNtDL5FaIPO_HIH4g">25 septembre 2020</a> : exclu (des mesures ont été prises en septembre, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li><a href = "https://www.lesechos.fr/economie-france/social/covid-la-decrue-dans-les-services-de-reanimation-esperee-en-france-dans-une-dizaine-de-jours-1261656">30 octobre 2020</a> : inclus (ce sont les modélisations du 2ème confinement, non publiées sur le site de l’Institut Pasteur mais retranscrites par la presse)</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/RapportInstitutPasteur_variants_8fevrier2021.pdf">8 février 2021</a> : inclus</li>
  <li><a href = "https://hal-pasteur.archives-ouvertes.fr/pasteur-03149525">23 février 2021</a> : inclus</li>
  <li><a href = "https://www.eurosurveillance.org/content/10.2807/1560-7917.ES.2021.26.9.2100133">29 mars 2021</a> : pas de scénario dans le rapport</li>
  <li><a href = "https://www.thelancet.com/journals/eclinm/article/PIIS2589-5370(21)00281-9/fulltext">6 avril 2021</a> : exclu (les courbes présentées sont un contrefactuel de l'évolution épidémique en l'absence de vaccination)</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/loosening/Scenarios_de_levee_des_mesures_de_freinage_20210426.pdf">26 avril 2021</a> : inclus </li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/loosening/Mise_a_jour_scenarios_de_levee_des_mesures_de_freinage_20210521.pdf">21 mai 2021</a> : il y a 3 semaines entre la publication de rapport et la prédominance du variant delta mi-juin. Cela permet une courte comparaison, menée de manière informelle <a href = "https://twitter.com/SCauchemez/status/1405129313721241603?cxt=HHwWhsC-_dDqgoAnAAAA">sur twitter </a> par Simon Cauchemez en charge de l'équipe modélisation de l'Institut Pasteur</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/Institut_Pasteur_dynamique_du_variant_Delta_en_France_metropolitaine_20210709.pdf">9 juillet 2021</a> : exclus (la mise en place du pass sanitaire n’était pas incluse dans les hypothèses de modélisation, les scénarios ne sont donc plus comparable avec la réalité)</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/Institut_Pasteur_Acceleration_vaccination_et_Delta_20210726.pdf">26 juillet 2021</a> : inclus (les scénarios prennent en compte la mise en place du pass)</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/InstitutPasteur_Dynamiques_regionales_des_hospitalisations_20210805.pdf">5 août 2021</a> : inclus (les scénarios prennent en compte la mise en place du pass sanitaire)</li>
  <li><a href = "https://hal-pasteur.archives-ouvertes.fr/pasteur-03272638v2">6 septembre 2021</a> : pas de scénarios dans le rapport</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/scenarios/InstitutPasteur_scenariosCOVID19AutomneHiver_2021.pdf">4 octobre 2021</a> : inclus</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/scenarios/Institut_Pasteur_diminution_de_limmunit%C3%A9_et_rappel_20211129.pdf">29 novembre 2021</a> : exclus (impact du variant Omicron 2 semaines plus tard, qui n'était pas pris en compte dans les modélisations). Nous avons tout de même pu comparer les projections à court terme durant la courte fenêtre de 2 semaines avant que le variant Omicron vienne fausser les résulats.</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/scenarios/Institut_Pasteur_Complement_rapport_rappel_20211202.pdf">2 décembre 2021</a> : exclus (impact du variant Omicron 2 semaines plus tard, qui n'était pas pris en compte dans les modélisations). Nous avons tout de même pu comparer les projections à court terme durant la courte fenêtre de 2 semaines avant que le variant Omicron vienne fausser les résulats. </li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/Institut_Pasteur_Impact_dOmicron_sur_lepidemie_francaise_20211227.pdf">27 décembre 2021</a> : pas encore analysé, le sera quand il y aura suffisamment de recul</li>
  <li><a href = "https://modelisation-covid19.pasteur.fr/variant/InstitutPasteur_Complement_Analyse_Impact_Omicron_20220107_corrige.pdf">7 janvier 2021</a> : pas encore analysé, le sera quand il y aura suffisamment de recul</li>
</ul>
  

</p>
</details>


<details><summary><b><div class="tooltip">Modélisations de l’INSERM
</div></b></summary>
<p>
<ul>
  <li>modélisations de janvier-février 2021: inclues car apparaissant dans le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport du Conseil Scientifique</a> du 29 janvier 2021 suggérant l’instauration d’un confinement strict. Elles ont également été diffusées dans la presse.</li>
  <li><a href = "https://www.epicx-lab.com/uploads/9/6/9/4/9694133/inserm_covid-19-voc_dominance-20210116.pdf">16 janvier 2021</a></li>
  <li><a href = "www.epicx-lab.com/uploads/9/6/9/4/9694133/inserm-covid-19-voc-lockdown-20210202.pdf">2 février 2021</a></li>
  <li><a href = "https://www.epicx-lab.com/uploads/9/6/9/4/9694133/inserm_covid-19-voc_socialdistancing-20210214.pdf">14 février 2021</a></li>
</ul>

</p>
</details>

<details><summary><b><div class="tooltip">Modélisations de l’Imperial College
</div></b></summary>
<p>
<ul>
  <li><a href = "https://www.imperial.ac.uk/mrc-global-infectious-disease-analysis/covid-19/report-12-global-impact-covid-19/">modélisations du rapport 12</a>, et notamment son <a href = "https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/Imperial-College-COVID19-Global-unmitigated-mitigated-suppression-scenarios.xlsx">appendice</a>: inclues car cités comme argument majeur en faveur du confinement dans le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport du Conseil Scientifique</a> du 12 mars 2020. Il a aussi été cité par de nombreux médias comme ayant été un argument décivif pour trancher en faveur du confinement, par exemple dans <a href = "https://www.lemonde.fr/planete/article/2020/03/15/coronavirus-les-simulations-alarmantes-des-epidemiologistes-pour-la-france_6033149_3244.html">Le Monde</a> ou dans <a href = "https://www.liberation.fr/evenements-libe/2020/03/16/l-urgence-eviter-la-saturation-des-services-de-sante_1781988/">Libération</a>  </li>
</ul>

</p>
</details>
