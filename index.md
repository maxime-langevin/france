
<link href="_assets/image.css" rel="stylesheet">
<style>
.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
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

# Comment évaluer la fiabilité des modelisations mathématiques sur la propagation du covid-19?

La fiabilité d'un modele est évaluée en comparant ses prévisions avec la réalité. 
Avec markdown tu *peux* faire **beaucoup** de choses.
Des listes par exemple:
1. First item
2. Second item
3. Third item
4. Fourth item 

Mais aussi des tables :
| Syntax      | Description |
| ----------- | ----------- |
| Header      | Title       |
| Paragraph   | Text        | 


> Des citations

Et mettre une emphase sur certaines choses <mark>très importantes</mark>

<details><summary><b><div class="tooltip">Hover over me
  <span class="tooltiptext">Tooltip text</span>
</div></b></summary>
<p>

<h3>même avec des images ;)</h3> 


<img src="images/media/media_novembre.png" width="400" alt="Pasteur aout">
    
<figure>
    <img src="images/media/media_novembre.png" width="400" alt="Pasteur aout">
    <figcaption class="figure-caption text-center">Name</figcaption>
</figure>


</p>
</details>

<!---Media (créer un onglet à part après)-->
<img src="images/media/media_novembre.png"  width="400"> <img src="images/media/media_juillet_SC.png"  width="400"> 


<!---Pasteur august (scenarios 26 july and 5 august)-->
<img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_hospital.png" width="400"> <img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_reanimation.png" width="400"> <img src="images/Pasteur_2021_Juillet/Pasteur_2021_juillet_reanimation_beds.png" width="400"> 
<img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_hospconv.png" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_new_hosp.png" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_new_reanimation.png" width="400"> <img src="images/Pasteur_2021_Aout/Pasteur_2021_aout_reanimation.png" width="400"> 

<!---INSERM and Pasteur january-february (scenarios 16/01, 02/02, 08/02 and 14/02)-->
<img src="images/INSERM/INSERM_16_janvier.png" width="400"> <img src="images/INSERM/INSERM_02_février.png" width="400"> <img src="images/INSERM/INSERM_14_février.png" width="400"> <img src="images/Pasteur_2021_Février/Pasteur_2021_Février.png" width="400"> 

<!---Pasteur november (scenario 30 october)-->
<img src="images/Pasteur_2020_Novembre/Pasteur_novembre_new_reanimations.png" width="400"> <img src="images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.png" width="400"> 

<!---Pasteur october (scenario 25 september)-->
<img src="images/Pasteur_2020_Octobre/Pasteur_octobre_reanimations.png" width="400"> 
 




# A quel moment des modélisations mathématiques ont éte faites, et quelle a éte leur fiabilité?

{% for post in site.posts %}
 
<ul>
 
<li><h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3></li>
 
</ul>
{% endfor %}



