# M122

## Team
- Tatjana Russo
- Jan Löliger

## Anforderungsdefinition

### Kundennutzen:

Mit dem Skript wird man täglich via Telegram benachrichtigt wie das morgige Wetter sein wird. In dieser Nachricht stehen Details wie die Höchst- und Tiefsttemperatur, die Niederschlagswahrscheinlichkeit und Wetterbedingung.

### Umgebung und Automation

Das Skript läuft auf einem Linux-Rechner (Ubuntu) und greift darin auf einen Telegram-Client zu, um Nachrichten versenden zu können.

Das Skript verarbeitet eine Konfigurationsdatei um den Standort zu bestimmen, damit die korrekten Wetterdaten ausgegeben werden können.

### Muss-Kriterien

Folgende Features sollen implementiert werden, um einen produktiven Ablauf sicherzustellen: 


- Wetterdaten von einer API herunterladen
- Wetterdaten als Nachricht via Telegram an Nutzer schicken
- Konfigurierbarer Standort
- Zeitfenster von den Wetterdaten selbst bestimmen (1-7 Tage)
- Anzeige der Höchst- und Tiefsttemperatur, Niederschlagswahrscheinlichkeit und Wetterbedingung

### Kann-Kriterien

Folgende Features können zusätzlich implementiert werden: 

- via SMS und nicht Telegram die Wetterdaten erhalten
- von mehreren Standorte die Wetterdaten erhalten (max. 3)
- Zusätzliche Anzeige von UV-Index, Luftfeuchtigkeit und Wettervorhersage für verschiedene Tageszeiten
- Sobald eine Wetterwarnung eintritt, wird der Nutzer direkt via Telegram/SMS benachrichtigt