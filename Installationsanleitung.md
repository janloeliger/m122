## Python
Um das Skript zum laufen zu bekommen, muss man im Vorfeld Python 3 installieren.

Auf Windows:  
[Installation](https://realpython.com/installing-python/#how-to-install-python-on-windows)

Auf Linux:  
[Installation](https://realpython.com/installing-python/#how-to-install-python-on-linux)

Danach mit dem Packagemanager pip muss man jq installieren mit folgendem befehl in der Konsole  
``pip3 install jq`` oder ``pip install jq``

Damit das Skript Täglich die Wetterdaten sendet und auf kommende gefahren prüfen kann muss einen Cronjob erstellt werden. Damit das passiert kann, muss man noch in der ``cron_installer.sh``-Datei den Pfad bei ``SCRIPT_PATH`` den Pfad zu der ``App.ssh``-Datei eingegeben werden. Danach kann manan folgende Datei ausführen mit:  
``./cron_installer.sh``
