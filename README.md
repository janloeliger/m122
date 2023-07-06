# M122

## Team
- Tatjana Russo
- Jan Löliger

## Dokumente
[Benutzeranleitung](https://github.com/janloeliger/m122/files/11965012/Benutzeranleitung.md)  
[Installationsanleitung](https://github.com/janloeliger/m122/files/11965015/Installationsanleitung.md)




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

### Design Configdatei (config.cfg)
```
# telegram 
telegram_chat_token=""
telegram_bot_token=""
# weather api (openweathermap)
weather_token=""
location=""
unit_type="" # metric or imperial
forecast_length_days=1 # Between 1 and 7 days
```
### Design Telegram-Message

Json welches gesendet wird:
```
{
  "ok":true,
  "result": [
    {
      "update_id":123,
      "channel_post": {
        "message_id":48,
        "chat": {
          "channel_id":5009754090,
          "title":"Notifications",
          "type":"channel"
        },
        "date":1574485277,
        "text":""
      }
    }
  ]
}
```

In das Feld ```text``` wird die Nachricht geschrieben. Die Nachricht wird nach volgendem Konzept versendet:
```
Guten Abend

Das Wetter morgen wird voraussichtlich so sein:
- Höchsttemperatur: 
- Tiefsttemperatur: 
- Niederschlagswahrscheinlichkeit: 
- Wetterbedingungen: -> Sonnig, Bewölkt etc...

Das Wetter in den Folgenden Tagen könnte so aussehen:
- Tag XYZ
    - Höchsttemperatur: 
    - Tiefsttemperatur: 
    - Niederschlagswahrscheinlichkeit: 
    - Wetterbedingungen: -> Sonnig, Bewölkt etc...
...
```

### Openweatherdata Request

Die Wetterdaten werden auf https://openweathermap.org/api#current geholt.

Vorraussichtlich wird der 16-Tage-Forcast verwendet (https://openweathermap.org/forecast16). Ein Request von dieser API könnte so aussehen:
```
{
  "city": {
    "id": 3163858,
    "name": "Zocca",
    "coord": {
      "lon": 10.99,
      "lat": 44.34
    },
    "country": "IT",
    "population": 4593,
    "timezone": 7200
  },
  "cod": "200",
  "message": 0.0582563,
  "cnt": 7,
  "list": [
    {
      "dt": 1661857200,
      "sunrise": 1661834187,
      "sunset": 1661882248,
      "temp": {
        "day": 299.66,
        "min": 288.93,
        "max": 299.66,
        "night": 290.31,
        "eve": 297.16,
        "morn": 288.93
      },
      "feels_like": {
        "day": 299.66,
        "night": 290.3,
        "eve": 297.1,
        "morn": 288.73
      },
      "pressure": 1017,
      "humidity": 44,
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ],
      "speed": 2.7,
      "deg": 209,
      "gust": 3.58,
      "clouds": 53,
      "pop": 0.7,
      "rain": 2.51
    },
    {
      "dt": 1661943600,
      "sunrise": 1661920656,
      "sunset": 1661968542,
      "temp": {
        "day": 295.76,
        "min": 287.73,
        "max": 295.76,
        "night": 289.37,
        "eve": 292.76,
        "morn": 287.73
      },
      "feels_like": {
        "day": 295.64,
        "night": 289.45,
        "eve": 292.97,
        "morn": 287.59
      },
      "pressure": 1014,
      "humidity": 60,
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ],
      "speed": 2.29,
      "deg": 215,
      "gust": 3.27,
      "clouds": 66,
      "pop": 0.82,
      "rain": 5.32
    },
    {
      "dt": 1662030000,
      "sunrise": 1662007126,
      "sunset": 1662054835,
      "temp": {
        "day": 293.38,
        "min": 287.06,
        "max": 293.38,
        "night": 287.06,
        "eve": 289.01,
        "morn": 287.84
      },
      "feels_like": {
        "day": 293.31,
        "night": 287.01,
        "eve": 289.05,
        "morn": 287.85
      },
      "pressure": 1014,
      "humidity": 71,
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ],
      "speed": 2.67,
      "deg": 60,
      "gust": 2.66,
      "clouds": 97,
      "pop": 0.84,
      "rain": 4.49
    },
    ....
```
### Activity-Diagram
![ad_ver1](https://github.com/janloeliger/m122/assets/90830948/126c385c-5729-458d-9161-c18eeca06b38)
