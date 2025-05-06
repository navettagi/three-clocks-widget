# Istruzioni per l'installazione

## Prerequisiti

- KDE Plasma 6
- Qt 5.15 o superiore

## Installazione manuale

1. Scarica o clona questo repository:

```bash
git clone https://github.com/yourusername/three-clocks-widget.git
```

2. Crea la directory di destinazione se non esiste già:

```bash
mkdir -p ~/.local/share/plasma/plasmoids/org.kde.plasma.threeclocks
```

3. Copia il contenuto del widget nella directory di destinazione:

```bash
cp -r three-clocks-widget/* ~/.local/share/plasma/plasmoids/org.kde.plasma.threeclocks/
```

4. Riavvia Plasma (opzionale, ma consigliato):

```bash
kquitapp5 plasmashell && kstart5 plasmashell
```

## Aggiungere il widget al desktop

1. Fai clic destro sul desktop
2. Seleziona "Aggiungi widget..."
3. Cerca "Three World Clocks" nell'elenco
4. Fai clic sul widget per aggiungerlo al desktop

## Configurare il widget

1. Fai clic destro sul widget
2. Seleziona "Configura Three World Clocks"
3. Nella finestra di configurazione puoi:
   - Abilitare/disabilitare la lancetta dei secondi

## Risoluzione dei problemi

Se il widget non appare nell'elenco dopo l'installazione:

1. Assicurati che i file siano stati copiati nella directory corretta
2. Verifica che i file abbiano i permessi corretti
3. Riavvia Plasma completamente (esci dalla sessione e rientra)

Per qualsiasi problema, apri una issue su GitHub.