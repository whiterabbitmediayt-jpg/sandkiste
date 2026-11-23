# Würfel-Scanner

Web-App, die einen Zauberwürfel (3×3) per Kamera einliest und die Lösung Zug für Zug zeigt.

## So funktioniert es

1. **Scannen**: Die sechs Seiten nacheinander vor die Kamera halten (Live-Kamera oder Foto). Ein 3×3-Raster zeigt, wo der Würfel sitzen soll.
2. **Erkennen**: Die Mittelfelder legen die sechs Farben fest. Alle 54 Felder werden so zugeordnet, dass jede Farbe genau 9-mal vorkommt (Hungarian-Algorithmus im Lab-Farbraum). Das macht die Erkennung robust gegen Licht und Kamerafarben.
3. **Prüfen**: Die App prüft, ob der Würfel physikalisch möglich ist (Ecken, Kanten, Verdrehung, Parität). Falsche Felder lassen sich per Antippen korrigieren.
4. **Lösen**: Kociemba-Zwei-Phasen-Algorithmus ([cubejs](https://github.com/ldez/cubejs)), meist ≤ 22 Züge. Eine 3D-Ansicht mit Drehpfeil zeigt jeden Zug, dazu eine Beschreibung auf Deutsch.

## Starten

`app.html` ist die Quelle, `build.sh` erzeugt daraus `index.html`.

Lokal (Live-Kamera funktioniert auf `localhost`):

```bash
cd rubiks-scanner && python3 -m http.server 8000 --bind 127.0.0.1
```

Dann <http://localhost:8000> öffnen. Für das Handy die Seite über HTTPS ausliefern, z. B. mit GitHub Pages. Ohne HTTPS erlauben Browser keinen Kamerazugriff.

## Auf der eigenen Website veröffentlichen

`build.sh` erzeugt den Ordner `website/` und daraus `wuerfel-scanner.zip`. Diese Version bringt Schriften und Löser selbst mit und stellt **keine Verbindung zu fremden Servern** her (keine Google Fonts, kein CDN). Das Kamerabild wird nur im Browser ausgewertet.

1. Den **Inhalt** von `website/` (oder die entpackte `wuerfel-scanner.zip`) in einen Unterordner der Website hochladen, z. B. `/wuerfel/`.
2. Aufrufen unter `https://deine-domain/wuerfel/`.

Voraussetzungen:
- Die Seite muss über **HTTPS** laufen, sonst erlauben Browser keinen Kamerazugriff.
- Die Dateien müssen als normale statische Dateien ausgeliefert werden (jedes übliche Webhosting, auch neben WordPress).

Bei Baukasten-Systemen ohne Datei-Upload (z. B. Wix, Jimdo, Squarespace) die App woanders statisch hosten und per iframe einbinden; der iframe braucht `allow="camera"`:

```html
<iframe src="https://ADRESSE-DER-APP/" allow="camera" style="width:100%;height:1800px;border:0" title="Würfel-Scanner"></iframe>
```

Lizenzen der mitgelieferten Dateien: cube.js/solve.js (MIT, `js/LICENSE-cubejs.txt`), Schriften Chakra Petch, IBM Plex Sans, JetBrains Mono (SIL Open Font License 1.1, `fonts/LICENSE-*.txt`).
