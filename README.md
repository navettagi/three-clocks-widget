# Three World Clocks Widget per KDE Plasma 6

Un widget per KDE Plasma 6 che mostra tre orologi analogici con gli orari di tre città: Roma, Doha e Ahmedabad.

## Caratteristiche

- Visualizzazione di tre orologi analogici verticalmente o orizzontalmente in base allo spazio disponibile
- Design semplice e leggibile con numeri delle ore, lancette ben visibili e orario digitale
- Fusi orari impostati per:
  - Roma, Italia (UTC+1, +2 durante l'ora legale)
  - Doha, Qatar (UTC+3, nessuna ora legale)
  - Ahmedabad, India (UTC+5:30, nessuna ora legale)
- Possibilità di abilitare o disabilitare la lancetta dei secondi
- Supporto per tema chiaro/scuro (testo e lancette sempre visibili)

## Installazione

Per installare il widget, esegui i seguenti comandi:

```bash
# Crea una directory locale per i widget Plasma se non esiste già
mkdir -p ~/.local/share/plasma/plasmoids/

# Copia il widget nella directory
cp -r three-clocks-widget ~/.local/share/plasma/plasmoids/org.kde.plasma.threeclocks
```

## Utilizzo

1. Fai clic destro sul desktop di KDE Plasma e seleziona "Aggiungi widget"
2. Cerca "Three World Clocks" nell'elenco dei widget
3. Aggiungi il widget al desktop
4. Fai clic destro sul widget e seleziona "Configura Three World Clocks" per attivare/disattivare la lancetta dei secondi

## Sviluppo

Questo widget è stato sviluppato per risolvere il problema di visualizzare in modo affidabile gli orari di tre città specifiche in un ambiente KDE Plasma 6. Utilizza:

- Canvas API di QtQuick per disegnare gli orologi analogici
- Calcolo degli orari basato su offsets UTC assoluti per garantire la massima precisione
- Layout flessibile per adattarsi a diverse dimensioni e proporzioni del widget

## Licenza

Questo widget è distribuito con licenza GPL-2.0+.