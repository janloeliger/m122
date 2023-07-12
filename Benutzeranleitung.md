## OpenWeather  
Auf der [OpenWeather Webseite](https://openweathermap.org/) einen Account erstellen und sich unter [API](https://openweathermap.org/api/one-call-3) einen API-Key erstellen lassen.


## Telegramm
1. Telegramm installieren und es einrichten
2. BotFather in der Suchleiste eingeben
3. Den Chat mit BotFather öffnen
4. mit ``/start`` die Konversation mit BotFather starten.
5. Den Befehl ``/newbot`` eingeben, um einen neuen Bot zu erstellen
6. Die Anweisungen des BotFather befolgen um einen Bot zu erstellen und den Bot-Token zu erhalten.
7. Konversation mit dem erstellten Bot anfangen um den Chat-Token zu erhalten.


## Konfiguration
Im Ordner namens config, die config.cfg Datei öffnen und:  
- bei der Variabel ``weather-token`` ihren API-Key eingeben  
- bei der Variabe ``telegram_bot_token`` ihren Bot-Token eingeben  
- bei der Variabel ``telegram_chat_token`` ihre Chat-ID eingeben
  
Ebenfalls kann man die ``location`` und den ``forecast_length_day`` beliebig anpassen, damit man die gewünschte Wettervorhersage erhält.

## Daten empfangen
Sollte alles korrekt aufgesetzt sein, wird man täglich um 19 Uhr über das kommende Wetter benachrichtigt. Zusätlich überprüft das Skript jede 5 Minuten ob eine Wetterwarnung erstellt wurde. Sollte dies der Fall sein wird sofort eine Nachricht an Telegram gesendet.

