# Select random student

Deze applicatie is gemaakt door HAN-AIM docent Sander Leer om tijdens een les makkelijk en eerlijk een willekeurige student uit te kiezen om deze een vraag te stellen of een opgave uit diens huiswerk te bespreken.

De applicatie is geschreven in [Processing](https://processing.org), een van Java afgeleidde taal met een eigen ontwikkelomgeving (IDE/editor) en inclusief een grafische library (verzameling functies) om studenten te leren programmeren doordat ze hiermee snel een visuele applicatie in elkaar kunnen zetten (tekening of animatie). Processing gebruiken we in de course SPD - Structured Program Development bij de Informatica en Communicatie Academie (ICA) van de Hogeschool Arnhem en Nijmegen (HAN).

## Hoe gebruik ik dit/start ik dit op?

<img src="screenshot.png" width="400" align="right">

Volg deze stappen.

1. Download processing 3.x van de [Processing website](https://processing.org/download/)
2. Hernoem het bestand `SelectRandomStudent/studenten`
3. Open in Processing de applicatie `SelectRandomStudent` in de gelijknamige subdirectory.
4. Pas de studenten lijst aan naar de lijst van voornamen van jouw klas
5. Toon te gebruiken knoppen in interface (self explaining)

De applicatie is getest in Processing v3.5.3. In het bestand `studenten.txt` vul je de namen in van je huidige klas. In principe de voornamen, in geval 1 naam vaker voorkomt kort onderscheid; bijvoorbeeld `Henk B.` en `Henk H.`. Het programma kent enkele toetsen voor de bediening en legt zichzelf on-screen uit. NB: Voorkom dat je echte studentnamen incheckt in git, zie opmerking hierover onderaan.

Het aanwezig zijn in een folder met naam `SelectRandomStudent` is een eis van Processing. De andere bestanden in de folder opent Processing dan direct in eigen tabs. Zo heeft Processing nog wat meer constraints, maar er is bewust gekozen niet over te gaan naar een Java variant om die extra complexiteit te vermijden ([KISS](https://nl.wikipedia.org/wiki/KISS-principe)).

## Waarom op GitHub?

Software is pas sowftware als het op GitHub staat, toch? 😉. Eén van de voordelen is om nieuwsgierige studenten in staat te stellen de broncode van de applicatie te bekijken. Om bijvoorbeeld te controleren dat deze inderdaad echt eerlijk is of hoe je zoiets nou bouwt. Dit is ook een mooie introductie in open source software, en geeft mogelijkheden ook social coding (zie 'zelf bijdragen' hieronder).

## Features

<img src="screenshot-lijst-scherm.png" width="400" align="right">

- [x] Selecteer random student
- [x] Lees de student namen in vanuit een .txt bestand
- [x] Markeer afwezige studenten en zorg dat ze niet opnieuw geselecteerd worden
- [x] Toon lijst van studenten en markeer hierin afwezigheid meerdere studenten tegelijkertijd
- [x] Voorkom dat dat je 2x dezelfde student aanwijst (e.g. 'no repitition' via 'shuffle' aanpak)

## Wanted

- [ ] Ondersteuning van studenten uit meerdere klassen via bijvoorbeeld meerdere tekstbestanden
- [ ] Integratie met iSAS voor studentnamen en/of aanwezigheid :smile
- [ ] Een webvariant hiervan (met bv. [p5js](https://p5js.org/))... (zie GitHub issues)

## Kan ik zelf bijdragen of feature requests doen?

Jazeker. Maak een issue aan, clone naar lokaal of fork it. Op een clean SOLID manier natuurlijk :). Een `CONTRIBUTING.md` komt wellicht tzt.

## Check NIET studenten namen in; denk aan de AVG

NB Deze repo bevat een test bestand met studentennamen in `studenten.txt` (dank aan [listofrandomnames.com/](http://listofrandomnames.com/)). Als jeze versie ook gebruikt in je les en met echte studenten namen vult, zorg dan dat je deze NIET incheckt hier op github! Daarom is deze ook opgenomen in het `.gitignore` bestand. En moet je een voorbeeld/template bestand eerst even hernoemen.

Een andere optie was om Git zo in te stellen dat het lokale wijzigingen in dit bestand negeert, met het volgende commando ([bron: Stephan Partzsch, 2015](https://blog.stephan-partzsch.de/how-to-ignore-changes-in-tracked-files-with-git/)):

`git update-index --skip-worktree SelectRandomStudent/studenten.txt`

Omdat elke developer dit apart doen moet, wat foutgevoeliger is, hebben we gekozen voor opname in `.gitignore` en de extra opstart stap om het bestand te hernoemen.

## Bronnen

- Partsch, S. 16-04-2015, geraadpleegd op 13-10-2022 van <https://blog.stephan-partzsch.de/how-to-ignore-changes-in-tracked-files-with-git/>
- List of random names, web util, geraadpleegd op 14-11-2019 van <http://listofrandomnames.com/>
- Processing, download, geraadepleegd op 13-10-2022 van <https://processing.org/download/>
