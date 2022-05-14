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








## <span style="color:black">Avant d'explorer les scénarios de modélisation</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Quel intérêt à étudier la fiabilité des scénarios de modélisations?
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Dans un cas de figure où les scénarios de modélisation sous-estiment l'évolution de l'épidémie (A), le risque est de ne pas réagir, ou pas assez. Inversement, si les scénarios surestiment l'évolution de l'épidémie (B), le risque est de surréagir et notamment de prendre trop de mesures aux effets déletères sans qu'elles soient justifiées. En effet, la plupart des mesures de freinage de l'épidémie (confinement, couvre-feu, fermeture de classes, fermetures de lieux publics) ont des impacts sanitaires, sociaux et économiques négatifs. Par conséquent, surréagir face à l'épidémie n'est pas une bonne chose (de même que ne pas réagir assez). <br /> 
    <img src="images/explication_simulation_enjeu.PNG" width="600">  <br /> 
    Une explication plus détaillée est disponible sur la page <a href="https://evaluation-modelisation-covid.github.io/france/impact">impact.</a>
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">L'intérêt des modélisations n'est-il pas justement d'empêcher qu'elles se produisent?
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Un argument souvent entendu au sujet des scénarios de modélisation est le suivant : comme le scénario permet d'anticiper le pire, il mène à prendre des mesures qui vont justement empêcher que le scénario modélisé se produisent, ce qui expliquent le décalage entre le scénario de modélisation et la réalité (où des mesures de freinage ont été prises!). Effectivement, il n'est pas possible d'établir une comparaison dans ce cas de figure. <br /> 
    <img src="images/pas_de_comparaison.PNG" width="600">  <br /> 
    Cependant, les scénarios de modélisation intègre souvent plusieurs hypothèses sur les mesures de freinage qui pourraient être mises en place. Ici, nous ne comparerons la réalité qu'avec des scénarios où les mesures de freinage mises en place avaient aussi été modélisées. <br /> 
    <img src="images/comparaison_explication.PNG" width="600">  <br /> 
    Ainsi, la comparaison entre scénarios de modélisation et réalité permettra bien d'évaluer si ceux-ci ont bien anticipé la réalité.
  </p>
</details>





## <span style="color:black">Retour sur les principaux scénarios de modélisation </span> 




### <span style="color:black">1. Mars 2020: les modélisations qui ont conduit le monde à se confiner</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    En mars 2020, l'incertitude sur les conséquences qu'allaient avoir le covid-19 était grande. Lorsque l'Italie a commencé à être fortement touchée à la mi-mars, de nombreux pays européens ont réalisé que le covid-19 risquait d'avoir un impact significatif.  Pour anticiper l'évolution de la pandémie, les décideurs se sont tournés vers le domaine de la modélisation épidémiologique. <br /> <br /> 
    Une équipe de scientifiques de l'Imperial College (Londres), menée par le Professeur Neil Ferguson, a notamment publié le 16 mars le <a href="https://www.imperial.ac.uk/mrc-global-infectious-disease-analysis/covid-19/report-9-impact-of-npis-on-covid-19/">rapport</a> qui a conduit de nombreux gouvernements européens, dont le gouvernement <a href="https://www.lemonde.fr/planete/article/2020/03/15/coronavirus-les-simulations-alarmantes-des-epidemiologistes-pour-la-france_6033149_3244.html">français</a>, à confiner leur pays. Les scénarios présentés dans le rapport anticipaient, en l'absence de mesures strictes, de l'ordre de 500 000 morts en moins de 3 mois au Royaume-Uni, et des chiffres similaires pour la France. En revanche, le rapport avançait que la mise en place de mesures strictes (type confinement) permettrait de contenir la vague et serait la seule manière d'éviter une saturation du système hospitalier. Se fiant à ce rapport, les gouvernements ont pour beaucoup choisi de mettre en place des mesures strictes.<br /> <br /> 
    Bien évidemment, les projections décrivant ce qu'il devrait se passer <em>en l'absence de mesures</em> ne peuvent être comparées avec ce qui s'est réellement passé dans les pays confinés. C'est d'ailleurs l'un des contre-arguments les plus communs aux détracteurs des modèles épidémiologiques: c'est précisément grâce aux mesures que les scénarios de modélisation ne se sont pas réalisés.<br /> <br />
    Mais il y a un pays qui nous permet de tester la validité des scénarios de modélisation: la Suède. Lors de la première vague, la Suède a choisi de ne pas se confiner, préférant se reposer des mesures plus légères. Il est donc possible de comparer ce que prévoyaient les scénarios pour la Suède et la réalité.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    L'<a href="https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/Imperial-College-COVID19-Global-unmitigated-mitigated-suppression-scenarios.xlsx ">appendice</a> du <a href = "https://www.imperial.ac.uk/mrc-global-infectious-disease-analysis/covid-19/report-12-global-impact-covid-19/">rapport 12</a> de l'Imperial College, publié le 26 mars, contient des modélisations de l'épidémie en Suède.  <br />  <br /> 
    Les 2 premiers graphiques représentent les pics de lits occupés en réanimation et à l'hôpital. Les barres grises représentent les scénarios de l'Imperial College : confinement strict précoce, confinement strict tardif, et aucune mesure. Les barres rouges représentent la réalité. La Suède ayant mis en place des mesures de distanciation sociale sans pour autant imposer un confinement, les chiffres observés auraient dû se trouver quelque part entre les scénarios "confinement" et "aucune mesure".
    La réalité est tout autre. Alors même que la Suède n'a PAS confiné sa population, les scénarios AVEC confinement surestiment le pic de lits utilisés de 100% à 1000%.<br /> <br /> 
    La 3e figure présente en gris les différents scénarios de l'Imperial College relatifs à la mortalité, et en rouge le nombre de morts réels. Là encore, les scénarios surestiment largement la mortalité. Le nombre de morts réels correspond au scénario de confinement précoce, ce qui n'a évidemment pas été l'approche suivie par la Suède. Les scénarios intermédiaires de distanciation sociale surestiment quant à eux la mortalité de 200% à 600%. <br />  <br /> 
  </p>
</details>

<img src="images/Imperial_Sweden/Sweden_icu.png" width="400"><img src="images/Imperial_Sweden/Sweden_hospital.png" width="400"><img src="images/Imperial_Sweden/Sweden_deaths.png" width="400">  <br /> 

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Ces modélisations furent un des principaux éléments déclencheurs du confinement national français (qui influencera d'autres pays européens à suivre la même voie). Dans son <a href="https://solidarites-sante.gouv.fr/IMG/pdf/avis_conseil_scientifique_12_mars_2020.pdf">rapport du 12 mars 2020</a>, le Conseil Scientifique a affirmé que les mesures classiques utilisées pour limiter la propagation des épidémies ne permettraient pas de limiter suffisamment la circulation du virus, impliquant la nécessité d'un confinement strict
    <blockquote cite="https://www.huxley.net/bnw/four.html">
      <p>
      <i>On ne s’attend pas à ce que la réduction de la taille du pic épidémique soit suffisante pour éviter une saturation du système de santé. (...) Cette intuition a été illustrée à travers la réalisation d’un modèle COVID19 particulier (Neil Ferguson, communication personnelle)</i> <br /><br />
      Extrait du rapport du Conseil Scientifique du 12 mars 2020
      </p>
    </blockquote>
    La figure présentée ci-dessus montrant que ces modèles surestimaient largement ce qui se passait avec des mesures classiques de contrôle des épidémies, cette affirmation était vraisemblablement fausse. <br /><br />
    L'influence politique de ces modélisation se poursuit bien après mars 2020. Lorsqu'en juillet 2021 le Tribunal Constitutionnel espagnol a déclaré inconstitutionnel le premier confinement, <a href ="https://www.courrierinternational.com/article/forme-espagne-un-confinement-juge-inconstitutionnel-des-milliers-damendes-remboursees">la ministre de la Justice a répliqué en assurant que ce dernier avait sauvé 450 000 vies en Espagne</a>. Si la source de ce chiffre n'est pas précisée, elle correspond bien au scénario pessimiste de l'<a href="https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/Imperial-College-COVID19-Global-unmitigated-mitigated-suppression-scenarios.xlsx ">appendice</a> du <a href = "https://www.imperial.ac.uk/mrc-global-infectious-disease-analysis/covid-19/report-12-global-impact-covid-19/">rapport 12</a> de l'Imperial College appliqué à l'Espagne. Le cas de la Suède interroge cette affirmation. En effet, si le gouvernement suédois avait confiné sa population, il aurait pu affirmer à l'image de la ministre espagnole que son action avait sauvé 90 000 personnes. Nous savons qu'il n'en est rien, le bilan réel sans confinement étant de 5000 morts, soit 18 fois moins.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Pour les décès, l'Imperial College a développé 4 scénarios : <br /> 
    <ol>
      <li>Aucune mesure</li>
      <li>Atténuation : distanciation sociale de la population de manière uniforme (40% de réduction des contacts)</li>
      <li>Atténuation : comme 2. mais en augmentant la distanciation sociale des plus de 70 ans (réduction des contacts de 60% pour cette catégorie)</li>
      <li>Suppression des transmissions : distanciation sociale élargie  et intense (réduction de 75% des contacts de l'ensemble de la population).</li>
    </ol>
    Il est impossible de mesurer la réduction de contacts effective, mais les données de mobilité peuvent fournir une approximation. En Suède, la fréquentation des lieux de travail, gares, et des lieux de commerce et loisirs a été réduite au maxiumum de 30-45%, et celle des magasins alimentaires et pharmacies de 10-15%. Cela semble confirmer que la Suède ne penchait pas vers le scénario 4, mais plutôt vers une atténuation légère. Pour comparaison, en France, la fréquentation des lieux de travail, de commerce et de loisir a été réduite de 70-90% et celle des magasins alimentaires de 50%, ce qui est aligné avec le scénario 4 de confinement. <br /> <br />
    <img src="images/Imperial_Sweden/Sweden_mobility.png" width="400"><img src="images/Imperial_Sweden/France_mobility.png" width="400"><br /> <br /> 
    Bien que ne correspondant pas à la réalité, nous avons fait le choix de représenter les scénarios "aucune mesure" pour plusieurs raisons :
    <ul>
      <li>Dans le cas des pics de réanimations et hospitaliers, aucun scénario intermédiaire n'a été produit, seulement les scénarios "confinement" et "0 mesure". Présenter ces 2 scénarios permet donc d'imaginer où aurait dû se trouver la réalité, quelque part entre les 2.</li>
      <li>Bien qu'irréalistes, les projections "aucune mesure" sont souvent mises en avant comme contrefactuel à l'absence de confinement, comme l'illustre le cas du pic hospitallier évoqué ci-dessus. C'est aussi le cas dans la presse (chiffre de <a href = "https://www.bfmtv.com/international/coronavirus-en-angleterre-les-projections-effrayantes-du-nombre-de-morts-en-cas-de-laisser-faire_AN-202003180090.html">500 000 morts au Royaume-Uni </a>) ou par le politique (chiffre de <a href = "https://www.courrierinternational.com/article/forme-espagne-un-confinement-juge-inconstitutionnel-des-milliers-damendes-remboursees">450 000 personnes sauvées</a> selon la ministre de la justice espagnole).</li>
    </ul>
  </p>
</details>








### <span style="color:black">2. Avril 2020: déconfinement de l'Ile-de-France</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Le 29 avril 2020, pendant le premier confinement, <a href = "https://www.lesechos.fr/idees-debats/editos-analyses/pourquoi-philippe-a-douche-les-francais-1199309"> un article du journal Les Echos </a> rapportait des modélisations de l’Institut Pasteur. Ces modélisations portaient sur l’évolution de l’épidémie post-confinement. Le ministère de la Santé indiquait alors que ces modèles sont non finalisés et en cours d'analyse, et par conséquent ne peuvent pas être rendus publics pour le moment. A notre connaissance ils n'ont pas été rendus publics par la suite.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Fin juin, le scénario optimiste surestime les données réelles de 66%. Les scénarios médian et pessimiste se situent eux 250% et 800% au-dessus des données réelles.
  </p>
</details>

<img src="images/Pasteur_2020_Avril/Pasteur_2020_Avril_reanimations.svg" width="400"><br /> 

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Bien que le rapport ayant conduit à ces modélisations n’a pas été à notre connaissance rendu public, celles-ci ont néanmoins été communiquées à la presse et à l'exécutif, comme le rapporte l'article des Echos :
    <blockquote cite="https://www.huxley.net/bnw/four.html">
      <p>
        Ce sont peut-être  les modélisations réalisées par l'Institut Pasteur pour l'ARS Ile-de-France et l'AP-HP - par le Pr Simon Cauchemez - qui invitent à la prudence le gouvernement. Datées de mardi et à vocation interne, elles montrent  que le nombre de patients en réanimation restera longtemps élevé, en tout cas jusqu'à l'été. Et cela quels que soient les scénarios.
      </p>
    </blockquote>
    La confidentialité du rapport dont sont issues ces courbes pose la question de la transparence des modélisations. De manière similaire, le <a href="https://solidarites-sante.gouv.fr/IMG/pdf/avis_conseil_scientifique_12_mars_2020.pdf">rapport du Conseil Scientifique du 12 mars 2020</a> faisait référence aux modélisations de l’Imperial College utilisées dans le rapport en ces termes “Neil Ferguson, communication personnelle”, sans information additionnelle. 
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les modélisations n'étant pas publiques, il ne nous a pas été possible d'étudier les hypothèses des scénarios. L'article des Echos fait simplement mention de différents taux de reproduction du virus, de 1.2, 1.5, ou plus.
  </p>
</details>








### <span style="color:black">3. Modélisations de la 2ème vague, et deuxième confinement</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Le 26 octobre, l’Institut Pasteur produit des scénarios d’évolution de l’épidémie en l’absence de confinement. Ce rapport n’a à notre connaissance pas été rendu public, et nous n’avons pas pu le consulter. Nous avons simplement trouvé une figure extraite du rapport, que l’on peut trouver sur cette <a href="https://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/"> page. </a><br /><br />
    <img src="images/Pasteur_2020_Novembre/Pateur_before_lockdown.png" width="400"> <br /><br />
    Le 28 octobre, face à la perspective présentée par ces chiffres, Emmanuel Macron annonce un confinement généralisé, qui prendra effet le 30 octobre.<br /><br />
    Le 30 octobre, l’Institut Pasteur produit une mise à jour de ses scénarios pour tenir compte de l’impact du confinement. Le rapport n’a pas été rendu public à notre connaissance. Certains médias y ont cependant eu accès, et ont reproduit les scénarios sous forme d’infographie. <a href="https://www.lesechos.fr/economie-france/social/covid-la-decrue-dans-les-services-de-reanimation-esperee-en-france-dans-une-dizaine-de-jours-1261656">L’article </a> des échos constitue notre source pour nos graphiques.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Le scénario le plus optimiste est proche du pic réel de lits occupés en réanimation (+15%). Le scénario médian et le plus pessimiste se trouvent eux à +30% et +100%.
  </p>
</details>

<img src="images/Pasteur_2020_Novembre/Pasteur_novembre_new_reanimations.svg" width="400"> <img src="images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.svg" width="400">   <br /> 

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les modélisations du 26 octobre ont été un des élément déclencheur du 2ème confinement. Notamment, <a href = "https://www.vie-publique.fr/discours/276951-emmanuel-macron-28102020-covid-19">lors de son allocution du 28 octobre</a>, Emmanuel Macron a annoncé que le nombre de patients en réanimation dépasserait les 9000 "quoi que nous fassions". Le pic réel sera deux fois moins élevé, à environ 4800 lits de soins critiques. On constate qu'en vue de justifier une décision politique, seule la modélisation la plus pessimiste a été mise en avant par l'exécutif. Elle a aussi été présentée comme une certitude, alors qu'il ne s'agissait que d'un scénario parmi d'autres. <br /><br />  
    Ces modélisations ont également été largement reprises dans la presse: <a href="https://www.lci.fr/sante/video-deuxieme-vague-les-scenarios-qui-inquietent-2168899.html">"Deuxième vague : les scénarios qui inquiètent"</a> titrait ainsi LCI après l'annonce du 2ème confinement, présentant les scénarios dont les pics de réanimation étaient de 5500, 6200 et 9000 patients. 
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Le rapport n'ayant pas été rendu public, il ne nous a pas été possible d'explorer en détail les hypothèses des scénarios. Selon les éléments rapoprtés par Les Echos, les différents scénarios correspondent à différentes valeurs de taux de reproduction "R" de 0.7 à 1.2, reflétant une efficacité plus ou moins marquée du confinement.
  </p>
</details>








### <span style="color:black">4. Entre la deuxième et la troisième vague: le couvre-feu étendu</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Au cours d'un hiver 2020-2021 marqué par un couvre-feu étendu, une dégradation de la situation sanitaire a mené l'INSERM et l'Institut Pasteur à publier des scénarios de modélisations de mi-janvier à mi-février. Ces scénarios ont servi de base pour envisager la mise en place d'un confinement strict début février, qui n'aura finalement pas eu lieu, offrant la possibilité de comparer les projections à ce qu'il s'est réellement passé.<br /> <br /> 
    De premiers confinements régionaux sont mis en place le 20 mars, suivis plus tard par d'autres jusqu'au confinement national le 3 avril. Le temps de latence entre la mise en place des mesures et leur effet sur les hospitalisations étant au minimum d'une semaine, voire 2 à 3 semaines comme l'indique le <a href ="https://solidarites-sante.gouv.fr/IMG/pdf/avis_conseil_scientifique_12_mars_2020.pdf">rapport du conseil scientifique</a>, nous arrêtons notre graphique au 27 mars. Au-delà, il n'est plus légitime de comparer la dynamique de la pandémie au scénarios "sans confinement".  <br /> <br /> 
    Avant ces dates, un certain nombre de mesures n'ont pas pu impacter la dynamique nationale de l'épidémie : le 25 février confinement le week-end à Dunkerque et une partie des Alpes-Maritimes, et le 4 mars confinement le week-end dans le Pas-de-Calais, ainsi que les centres commerciaux de plus de 10 000 m2 fermés.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles: Scénarios de l'INSERM
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les scénarios réalisés pendant 1 mois pointent tous vers une augmentation exponentielle des admissions à l'hôpital. La réalité sera une légère diminution suivi d'une augmentation ramenant environ au niveau initial. Quasiment tous les scénarios dépassent les 30 000 admissions hebdomadaires avant la mi-mars sans signe de ralentissement de la dynamique, alors que la réalité se trouvait aux alentours de 10 000, soit 3 fois moins. Le scénario le plus optimiste surestime les hospitalisation d'un 50-100%. <br /> <br /> 
  </p>
</details>
  
<img src="images/INSERM/INSERM_16_janvier.svg" width="400"> <img src="images/INSERM/INSERM_02_février.svg" width="400">  <img src="images/INSERM/INSERM_14_février.svg" width="400">  <br /> 

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles: Scénarios de l'Institut Pasteur
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Pour le rapport du 8 février, les 2 scénarios principaux se prolongeant en mars reflètent une hypothèse "sans vaccination" et une hypothèse "optimiste" de vaccination. Il est précisé qu’ « en pratique, l’impact de la campagne actuelle est susceptible d’être intermédiaire entre les scénarios avec et sans vaccination », d'où notre choix de représenter ces 2 courbes. Plus loin dans le rapport sont présentés 2 autres variantes secondaires illustrant l'influence d'une faible variation du taux de reproduction : ce sont les courbes s'arrêtant en mars. <br /> <br />
    Seul le scénario le plus optimiste colle à la réalité, bien que ce n'était pas le scénario principal présenté aux décideurs. Les autres surestiment les admissions réelles d'un facteur 50-100%. <br /> <br />
    Pour le rapport du 23 février, le scénario sans confinement présenté colle bien aux observations. Il n'est pas fait mention du décalage observé entre la réalité et les scénarios publiés 15 jours auparavant. <br /> <br />
  </p>
</details>

<img src="images/Pasteur_2021_Février/Pasteur_2021_Février.svg" width="400"><img src="images/Pasteur_2021_Février/Pasteur_2021_Fevrier_bis.svg" width="400">  <br /> 

<details>
  <summary>
    <b>
      <div class="tooltip">Auto-évaluation de l'Institut Pasteur
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Une évaluation rétrospective portant sur le rapport du 8 février sera faite dans <a href = "https://modelisation-covid19.pasteur.fr/loosening/Scenarios_de_levee_des_mesures_de_freinage_20210426.pdf">un rapport ultérieur du 26 avril </a>. Il y est indiqué que 
    <blockquote cite="https://www.huxley.net/bnw/four.html">
      <p>
      <i>"dès le 8 février, ce modèle avait anticipé que le couvre-feu serait efficace pour contenir la circulation du virus historique mais n'empêcherait pas une augmentation importante des hospitalisations en l'absence de mesures supplémentaires"</i>
      </p>
    </blockquote> 
    Cette affirmation est accompagnée de la figure ci-dessous. En presque 2 ans, du début de la pandémie en mars 2020 à la vague Omicron début 2022, cette figure constituera la seule comparaison rétrospective officiellement publiée par l'Institut Pasteur.<br /> <br />
    Nous n'avons cependant pas trouvé une telle projection dans le <a href="https://modelisation-covid19.pasteur.fr/variant/RapportInstitutPasteur_variants_8fevrier2021.pdf"> rapport du 8 février</a>. Toutes celles que nous avons trouvée sont représentées sur nos graphiques présentés ci-dessus.<br /> <br /> 
    <img src="images/Pasteur_2021_Février/comparaison_pasteur.png" width="600" align="center"><br /> <br /> 
    
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les prévisions de l'INSERM ont été mises en avant dans un <a href="https://solidarites-sante.gouv.fr/IMG/pdf/note_eclairage_variants_modelisation_29_janvier_2021.pdf">rapport spécial</a> du Conseil Scientifique qui demandait la mise en place d'un confinement strict à partir du lundi 8 février 2021. Selon ces modélisations, le nombre d'hospitalisations hebdomadaires aurait dû être de plus de 30 000 à cette date (en réalité autour de 10 000), et continuer d'augmenter exponentiellement sans confinement strict (qui n'aura finalement lieu qu'un mois plus tard). 
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    A propos des scénarios de l'INSERM :
    <ul>
      <li>rapport du 16 janvier : les scénarios correspondent à 3 taux de reproduction du variant historique (1, 1.1 et 1.2), couplés à un variant alpha 50% ou 70% plus transmissible. Les courbes sont issues de la figure 1.</li>
      <li>rapport du 2 février : les scénarios correspondent à 3 taux de reproduction du variant historique (0.9, 1.1 et 1.2) couplés à un variant alpha 50% plus transmissible. Les courbes sont les courbes grises de la figure 2 (redondance avec les courbes des figures 1 et 2).</li>
      <li>rapport du 14 février : variant alpha 50% plus transmissible. La transmissibilité du virus historique, n'est pas renseignée. En plus de la projection standard, 2 scénarios explorant une variation de la transmission du variant historique de +/- 10% illustrent un allègement ou un renforcement des mesures. La réalité n'a correspondu à aucun de ces 2 cas de figure, mais nous avons fait le choix de représenter ces 2 scénarios pour ne pas nous faire accuser d'exclusion arbitraire (la variation de 10% pouvant se produire naturellement de manière aléatoire).</li>
    </ul>
    A propos des scénarios de l'Institut Pasteur :
    <ul>
      <li>rapport du 8 février : les scénarios correspondent à 3 taux de reproduction du variant historique (0.9, 0.95 et 1), couplés à un variant alpha 40%, 50% ou 70% plus transmissible. Les courbes sont issues des figures 2a, 6a, 7c</li>
      <li>rapport du 23 février :  de nombreuses variantes sont proposées, car comme le souligne le rapport face à la grande incertitude "une unique prévision pour les prochains mois n'est pas possible". Dans le détail les différentes hypothèses portent sur la plus grande transmissibilité du variant alpha (+40%, 50% ou 70%) et un changement de trajectoire épidémique (dminution et augmentation de 8% ou 16%) qui intervient à différentes dates (22 février ou 8 mars). Les courbes sont extraites des figures 2c, 5a, 5c, 5e, en s'arrêtant au 27 mars comme expliqué dans le paragraphe "contexte".</li>
    </ul>
    Le rapport du 16 janvier de l'INSERM mérite précision, car il y est dit que l'effet du couvre-feu anticipé à 18 heures n'est pas pris en compte, mais que le scénario le plus optimiste pourrait refléter la mesure. Aurions-nous dû ne garder que celui-ci et exclure les autres scénarios ? Notre décision de tous les conserver s'appuie sur plusieur points :
    <ul>
      <li>Tout d'abord les auteurs ont fait le choix de les représenter, indiquant qu'ils validaient eux-mêmes la pertinence de ces scénarios. En effet ils n'hésitent pas à affirmer que "les nouvelles hospitalisations devraient atteindre environ 25 000 entre mi-février et début avril en l’absence d’intervention" »</li>
      <li>En s'appuyant sur ces résultats, ils n’hésitaient pas non plus à donner des recommendations politiques explicites « Ces résultats montrent la nécessité de renforcer les mesures de distanciation sociale » et ce alors même bien que le couvre-feu, dont le but même est d'éviter des mesures plus restrictives, n'était pas modélisé…</li>
      <li>Enfin, on voit que les scénarios du 16 janvier sont très similaires à ceux du 2 février, alors même que ceux-ci "intègrent de façon effective toutes les mesures de distanciation sociale", indiquant que la prise en compte du couvre-feu ne change pas grand-chose</li>
  </p>
</details>









### <span style="color:black">5. Sortie du 3e confinement</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Des scénarios sont sortis les <a href = "https://modelisation-covid19.pasteur.fr/loosening/Scenarios_de_levee_des_mesures_de_freinage_20210426.pdf">26 avril</a> et <a href = "https://modelisation-covid19.pasteur.fr/loosening/Mise_a_jour_scenarios_de_levee_des_mesures_de_freinage_20210521.pdf">21 mai</a>, portant sur les trajectoires épidémiques pour la sortie du 3e confinement et l'été. Nous arrêtons les comparaisons à la mi-juin, moment de l'apparition variant delta, non pris en compte dans les modèles. <br /> <br /> 
    Pour le rapport du 21 mai, nous n'avons pas eu besoin de mener nous-mêmes une analyse. En effet Simon Cauchemez, en charge de l'équipe modélisation de l'Institut Pasteur, avait déjà publié une comparaison informelle sur <a href = "https://twitter.com/SCauchemez/status/1405129313721241603?cxt=HHwWhsC-_dDqgoAnAAAA"> son compte twitter</a>, reproduite ici. A notre connaissance cela n'a pas été fait pour le rapport du 26 avril, et nous avons donc procédé nous-mêmes à la comparaison.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Pour le premier rapport, les scénarios se situent à la mi-juin au-dessus de la réalité, la surestimation allant d'un peu moins de 100% à 500%. <br /><br />
    En revanche la décrue observée suit fidèlement le scénario du second rapport, comme le montre la capture d'écran de Simon Cauchemez. Ce dernier ne fait pas mention du premier rapport.
  </p>
</details>

<img src="images/Pasteur_2021_Avril/Pasteur_2021_avril_new_hospital.svg" width="400"><img src="images/Cauchemez.png" width="400">

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Ces modélisations ont appuyé le rapport du Conseil Scientifique du <a href="https://www.vie-publique.fr/sites/default/files/rapport/pdf/279792.pdf">6 mai 2021.</a> Bien que le Conseil Scientifique précise que “Ces projections [...] ne sont pas des prédictions”, il s’appuie sur celles-ci pour estimer que “sous des hypothèses plausibles, un rebond important de l’épidémie est possible durant la période estivale si les mesures de contrôle sont relâchées trop rapidement, et cela même lorsqu’on considère un rythme important de vaccination.”. C’est un des arguments qui à poussé le Conseil Scientifique à se positionner en faveur d’une réouverture des activités sociales “prudente et maîtrisée" suite au 3ème confinement.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Pour le rapport du 26 avril, les courbes sont extraites des figures 3b et 3d. Les hypothèses faites dans les scénarios sont les suivantes :
    <ul>
      <li>Un variant alpha plus transmissible de 60% ou 40% comparé à la souche originelle</li>
      <li>Des levées des mesures plus ou moins rapides, se traduisant par des taux de reproduction de reprise R de 1 à 1.3, à partir du 15 mai. Nous avons exclu le scénario le plus pessimiste (R = 1.3) qui correspondait à une levée quasi totale des mesures dès la mi-mai, ce qui n'a pas été le cas.</li>
      <li>Des hypothèses médianes ou pessimistes concernant la réduction des hospitalisations</li>
      <li>Un rythme de distribution des doses de vaccin de 350 000 ou 500 000 doses par jour. Nous n'avons retenu que les scénarios à 500 000 doses/jour, qui sont proches de la réalité, comme le montre le graphique ci-dessous.</li>
    </ul>
      <img src="images/Pasteur_2021_Avril/vaccine_doses_april.png" width="600"> <br /><br />
    Pour le rapport du 21 mai, nous n'avons pas eu besoin de vérifier les hypothèses, Simon Cauchemez ayant lui-même comparé la trajectoire épidémique à ses scénarios.<br /><br />
    Dans les 2 cas nous arrêtons la comparaison à la mi-juin, lorsque l'apparition du variant delta non prévue par les modèles rend les hypothèses caduques.
  </p>

</details>











### <span style="color:black">6. Modélisations de la 4ème vague et variant delta</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Un premier rapport de l’Institut Pasteur est sorti le <a href="https://modelisation-covid19.pasteur.fr/variant/Institut_Pasteur_dynamique_du_variant_Delta_en_France_metropolitaine_20210709.pdf">9 juillet 2021</a> dans un contexte de propagation du variant delta. Deux des trois scénarios présentés anticipaient pour fin août un nombre de lits de soin critiques au moins égal à la 2ème vague, et en l’absence de mesures un pic courant septembre bien au-dessus de la 1ere vague.<br /> <br />
    Face à la perspective d’une submersion hospitalière que suggéraient ces scénarios, le passe sanitaire élargi a été acté le 21 juillet, entraînant une forte augmentation des vaccinations et rendant caduques les hypothèses  du rapport du 9 juillet. <br /> <br />
    Pour remédier à cela, l’Institut Pasteur a publié 2 nouveaux rapports, les <a href="https://modelisation-covid19.pasteur.fr/variant/Institut_Pasteur_Acceleration_vaccination_et_Delta_20210726.pdf">26 juillet</a> et <a href="https://modelisation-covid19.pasteur.fr/variant/InstitutPasteur_Dynamiques_regionales_des_hospitalisations_20210805.pdf">5 août</a>, afin de tenir compte de l’effet du pass sanitaire ; ce sont ces 2 rapports que nous comparons à la trajectoire réelle.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p> 
    Pour le premier rapport, la réalité est environ 2 fois moins grande que les scénarios les plus optimistes, 3 à 4 fois moins grande que les scénarios médians, 10 fois moins grande que les scénarios pessimistes.<br /><br /> 
    Le rapport publié 10 jour plus tard corrige partiellement cette surestimation, la réalité correspondant environ au scénario le plus optimiste, mais restant 2 fois moins grande que le scénario médian et 4 fois moindre que le scén
  </p>
</details>
  
<h4 style="color:black">Scénarios du 26 juillet</h4> 
  
<img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_hospital.svg" width="400"> <img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_reanimation.svg" width="400"> <img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_reanimation_beds.svg" width="400">  <br /> 
  
<h4 style="color:black">Scénarios du 5 août</h4> 
  
<img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_new_hosp.svg" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_new_reanimation.svg" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_hospconv.svg" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_reanimation.svg" width="400">  <br /> 

  
<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    En ligne avec les projections présentées, le président du conseil scientifique Jean-François Delfraissy prévoyait alors une situation hospitalière compliquée pour fin août lors de son audition <a href="https://www.publicsenat.fr/article/parlementaire/covid-19-jean-francois-delfraissy-prevoit-une-situation-tres-complexe-dans-les">devant les sénateurs.</a> Il <a href="https://www.publicsenat.fr/article/parlementaire/covid-19-jean-francois-delfraissy-prevoit-une-situation-tres-complexe-dans-les">prévoyait également</a> que l'on allait :
    <ul>
      <li>"arriver aux 50 000 cas probablement début août " (le pic réel, atteint le 16 août, était 2 fois moindre, à <a href="https://www.gouvernement.fr/info-coronavirus/carte-et-donnees#situation_epidemiologique_-_nombre_moyen_de_nouveaux_cas_confirmes_quotidiens">moins de 25 000 cas</a>)</li>
      <li>"Le modèle montre bien que d’ici fin août, nous allons nous trouver dans une situation très complexe, avec un impact sur le système de soins"</li>
    </ul>
    Cette mise en avant des projections de l'Institut Pasteur au Sénat est intervenu avant que celui-ci ne se prononce sur l'extension du pass sanitaire, et a donc pu jouer un rôle dans l'avis des sénateurs. <br /><br />
    Les modélisations de l'Institut Pasteur ont été également <a href="https://www.conseil-etat.fr/Media/actualites/documents/2021/07-juillet/454792-454818.pdf">utilisé par le Conseil d'Etat comme argument</a> pour rejeter les demandes de référés-libertés au sujet de l'extension du pass sanitaire. Pour rejeter ces demandes, le Conseil d'Etat a notamment expliqué que les données "pourraient se révéler encore plus préoccupantes au début du mois d’août, selon les modélisations de l’Institut Pasteur."
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Le scénarios du premier rapport sont extraits des figures 4, 5 et 6. Les scénarios dont les hypothèses ne collaient pas à la réalité ont été exclus de la comparaison, permettant de ramener le nombre de variantes de 108 à seulement 6 pour les admissions et 12 pour le nombre de lits occupés. Détails des hypothèses : 
    <ul>
      <li>Durée de passage en soins critiques : 14.6 jours ou 10 jours</li>
      <li>Réduction du nombre de reproduction effectif le portant à 1.5, 1.8 ou 2 en raison des mesures barrières et du pass sanitaire.</li>
      <li>Adhésion vaccinale des >60 ans : 90 ou 95%. Nous avons seulement retenu les scénarios 90%, en ligne avec le graphique ci-dessous.</li>
      <li>Adhésion vaccinale des 18-59 ans : 70% ou 90%. Nous avons seulement retenu les scénarios 90%, en ligne avec le graphique ci-dessous.</li>
      <li>Adhésion vaccinale des 12-17 ans : 30%, 50% 70%. Nous n'avons pas eu besoin de vérifier cette hypothèse, car pour une haute couverture vaccinale des adultes (90%), la vaccination des adolescents n'a aucune incidence sur la trajectoire hospitalière selon les propres résultats du rapport.</li>
      <li>Doses de vaccins distribués par jour : 500 000, 700 000 ou 800 000. Nous avons éliminé les scénarios à 800 000 doses/jour, trop éloignés de la réalité (voir graphique ci-dessous). Celui à 700 000 ne correspond qu'au début du mois d'août, mais nous avons fait le choix de le conserver.</li>
    </ul>
    Le second rapport fait uniquement des hypothèses sur la durée de passage en soins critiques (10, 14 ou 17 jours) et sur le nombre de doses de vaccin distribuées par jour (600 000, 700 000 800 000). Au vu des chiffre ci-dessous, nous avons exclus les scénarios à 700 000 et 800 000 doses/jour.
<img src="images/Pasteur_2021_Juillet/vaccination_juillet.png" width="600"> 
<img src="images/Pasteur_2021_Juillet/vaccine_doses_juillet.png" width="600"> 
  </p>
</details>










### <span style="color:black">7. Levée des restrictions: Freedom Day au Royaume-Uni</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les modélisations présentées plus tôt permettent de comparer la réalité et les scénarios lorsque des restrictions sont en place. Mais comment se comparent les scénarios et la réalité dans le cas où les mesures de restrictions sont levées? <br /> <br /> 
    Pour donner un élément de réponse à cette question, nous présentons une comparaison entre scénarios de modélisation et réalité dans le cas du "Freedom day", jour de levée de la quasi-totalité des mesures restrictives au Royaume-Uni. Le 19 juillet, dans le cadre de son plan de sortie de crise, le gouvernement britannique a en effet décidé de <a href="https://news.sky.com/story/covid-19-what-are-the-remaining-rules-in-england-after-freedom-day-12359221">lever</a> la plupart de ses mesures de restrictions (telles que limitations de capacité dans les lieux accueillant du public, port du masque obligatoire ou encore limitations de déplacement). <br /> <br /> 
    Contrairement à d'autres pays européens, ce retour à la normale ne comprenait pas la mise en place d'un "pass sanitaire" pour accéder à des événements ou lieux publics. 
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Les données présentées ci-dessous comparent la réalité des patients hospitalisés avec les différents scénarios de modélisations visant à prévoir l'impact de la levée des restrictions. Les données sont <a href="https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1001169/S1301_SPI-M-O_Summary_Roadmap_second_Step_4.2__1_.pdf">issues</a> du rapport du 7 juillet du SAGE (Scientific Advisory Group for Emergencies), et la mise en forme provient du site du <a href="https://data.spectator.co.uk/category/sage-scenarios">Spectator</a>.<br /><br />
    Le pic réel se trouve sous le scénario le plus optimiste, les scénarios médians sont 2 à 3 fois supérieurs, et le scénario le plus pessimiste est plus de 5 fois supérieur.
  </p>
</details>

<img src="images/sage_scenarios.png" width="600">

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Cette levée des restrictions avait été fermement critiquée par de nombreux scientifiques dans une lettre ouverte au prestigieux journal médical <a href="https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(21)01589-0/fulltext">The Lancet</a>, qui l'avait qualifiée de "dangereuse et prématurée". Cette lettre ouverte a été reprise par différents médias  <a href="https://www.dailymail.co.uk/news/article-9766759/Experts-sign-letter-condemning-Government-s-dangerous-unethical-experiment.html">britanniques</a> et <a href="https://edition.cnn.com/2021/07/18/uk/boris-johnson-covid-gamble-freedom-day-intl-gbr-cmd/index.html">internationaux</a>, qui s'appuyaient sur les modélisations de l'Imperial College pour annoncer "une troisième vague importante d'hospitalisations et de décès" à la suite de la levée des restrictions.<br /> <br /> 
    Le fait que les modélisations aient largement surestimées l'impact de la réouverture a été <a href="https://www.nature.com/articles/d41586-021-02125-1">décrit</a> dans le journal scientifique Nature par un épidémiologiste renommé: 
    <blockquote cite="https://www.huxley.net/bnw/four.html">
      <i>Personne ne comprend vraiment ce qu'il se passe.</i>
    </blockquote>
  </p>
</details>










### <span style="color:black">8. Automne-hiver 2021</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Dans un contexte notamment marqué par la généralisation du pass sanitaire, l’Institut Pasteur a publié des modélisations sur la dynamique de l’épidémie pendant la transition automne-hiver. Bien que l’arrivée du variant Omicron ait rendu obsolète ces modélisations courant décembre, il reste une période de 2 mois sur laquelle elles peuvent être comparées à la réalité.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des scénarios aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>

  </p>
</details>

<img src="images/Pasteur_2021_Octobre/Pasteur_2021_octobre_new_hosp.svg" width="400">

<details>
  <summary>
    <b>
      <div class="tooltip">Impact politique et médiatique
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    Ces modélisations ont été <a href="https://www.huffingtonpost.fr/entry/pass-sanitaire-modelisations-de-linstitut-pasteur-qui-guident-le-gouvernement_fr_615f1428e4b09f3389721226">reprises</a> par le Conseil Scientifique dans son rapport du <a href="https://solidarites-sante.gouv.fr/IMG/pdf/avis_conseil_scientifique_5_octobre_2021.pdf">5 octobre 2021.</a> Il s’est appuyé dessus notamment pour recommander de maintenir le pass sanitaire pendant une période courant a minima jusqu’au 15 novembre 2021 (première prolongation du pass sanitaire). Elles ont été également reprises dans la <a href="https://www.francetvinfo.fr/sante/maladie/coronavirus/covid-19-en-france-l-institut-pasteur-juge-improbable-une-reprise-importante-de-l-epidemie-cet-hiver_4800973.html">presse</a> nationale.
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
3 scénarios : référence relachement ; "actuel" réduction de 40% // juin ; intermédiaire -20%. Reflètent les mesures et les comportements
figure 7 les 2 du haut
aussi figure 9 efficacité vaccinale
on arrête au 20 décembre avec omicron
  </p>
</details>

  
  
  
  
  
  
  

### <span style="color:black">9. Seconde vague delta, décembre 2021</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ces projections</span>
      </div>
    </b>
  </summary>
  <p>
    Dans un contexte de seconde vague delta, l'Institut Pasteur a produit 2 rapports le <a href ="https://modelisation-covid19.pasteur.fr/scenarios/Institut_Pasteur_diminution_de_limmunit%C3%A9_et_rappel_20211129.pdf"> 29 novembre </a> et le <a href ="https://modelisation-covid19.pasteur.fr/scenarios/Institut_Pasteur_Complement_rapport_rappel_20211202.pdf"> 2 décembre 2021 </a> avec des scénarios couvrant l'hiver et le printemps 2022. Malheureusement l'émergence du variant omicron 2 semaines plus tard rend caduques les hypothèses et ne permet pas une comparaison à la réalité. <br /><br />
    Une critique souvent apportée à la comparaison des données réelles aux “scénarios” telle que réalisée ci-dessus est que ces derniers ne constituent pas des “prédictions”, et servent simplement à donner une idée des grandes tendances et de l’impact de différentes mesures. <br /><br />
    Néanmoins, au-delà des scénarios présentés dans ses rapports, l’Institut Pasteur publié également des “Projection à court terme des besoins hospitaliers” sur <a href = "https://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/"> cette page </a>, régulièrement mise à jour. Ici, le but est bien de prévoir correctement le nombre de malades, l’Institut précisant que “l’erreur relative pour les projections du nombre de lits de soins critiques au niveau national est de 11% à 14 jours.“ <br /><br />
    Nous comparons ici la projection du modèle 2 semaines avant le pic de la seconde vague delta de mi-décembre 2021. Ce pic est intervenu juste avant l’émergence du variant omicron, qui a changé la donne dans les semaines qui ont suivi. <br /> <br />
  </p>
</details>  
 
<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des projections aux données réelles
        <span class="tooltiptext">Explorer ces projections</span>
      </div>
    </b>
  </summary>
  <p>
    Au moment du pic du variant delta, la projection du modèle correspond à une surestimation 2 semaines plus tard de 30% pour les lits de soins critiques, et d’environ 40% pour les autres indicateurs. <br /> <br /> 
    Malgré une précision moyenne de 10% du modèle, au moment du pic l’erreur réelle aura été bien plus élevée. Nous aurions souhaité comparer les projections du modèle aux autres pics (février 2021, avril 2021, août 2021) afin d’évaluer s’il s’agissait d’une erreur ponctuelle ou d’un biais systématique sur les pics. Une telle évaluation est importante car c'est l'anticipation d'un pic hospitalier qui conditionne la réponse politique. <br /> <br /> 
    Malheureusement la mise à jour régulière des projections sur <a href = "https://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/">la page présentant les résultats</a> écrase les projections publiées précédemment, et nous n’avons pas pu effectuer cette évaluation systématique. Une conservation des résultats précédents en open data aiderait une telle démarche et une appropriation par les citoyens.
  </p>
</details>

<img src="images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_hosp.svg" width="400"><img src="images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_SC.svg" width="400"><img src="images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_hosp.svg" width="400"><img src="images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_SC.svg" width="400">

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer ces projections</span>
      </div>
    </b>
  </summary>
  <p>
    Il n'y pas de respect des hypothèses à vérifier pour ces projections. L'horizon de 2 semaines est trop court pour qu'une mesure mise en place après publication viennent modifier la trajectoire épidémique. En effet, comme le rappelle <a href="https://solidarites-sante.gouv.fr/IMG/pdf/avis_conseil_scientifique_12_mars_2020.pdf">le rapport du conseil scientifique</a>, "les premiers effets des mesures adoptées [...] ne peuvent apparaître qu'après deux à trois semaines".
  </p>
</details>









### <span style="color:black">10. Vague Omicron, janvier 2022</span>

<details>
  <summary>
    <b>
      <div class="tooltip">Contexte
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    
  </p>
</details>  
  
    


2 types d'efficacité vaccinale étaient explorés. Lorsqu'il y aura suffisamment de recul, nous sélectionnerons le cas qui colle aux données cliniques réelles :  <br /> 

<img src="images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_high_VE.svg" width="400"><img src="images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_low_VE.svg" width="400"><br /><br /> 

Par ailleurs, au-delà des hypothèses d'efficacité vaccinale, des scénarios "moins probables" étaient également présentés. Nous les présentons ici en pointillés <br /> 

<img src="images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_all.svg" width="400"><br /> 
 
<details>
  <summary>
    <b>
      <div class="tooltip">Comparaison des projections aux données réelles
        <span class="tooltiptext">Explorer ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    
  </p>
</details>

<details>
  <summary>
    <b>
      <div class="tooltip">Discussion sur les hypothèses des scénarios (technique)
        <span class="tooltiptext">Explorer  ce scénario</span>
      </div>
    </b>
  </summary>
  <p>
    
  </p>
</details>







