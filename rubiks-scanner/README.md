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
cd rubiks-scanner && python3 -m http.server 8000
```

Dann <http://localhost:8000> öffnen. Für das Handy die Seite über HTTPS ausliefern, z. B. mit GitHub Pages. Ohne HTTPS erlauben Browser keinen Kamerazugriff.
