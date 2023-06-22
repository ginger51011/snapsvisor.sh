# Automatiskt Genererat Sånghäfte (Patent Pending)

_Tack till GPT-4 för hjälpen och min framtida redundans!_

För att bygga behöver du ha `pandoc` och `pdfbook2` installerat. På Ubuntu
kan du använda

```
sudo apt install pandoc texlive-extra-utils
```

för detta.

För att bygga projektet kör du bara

```
./build.sh
```

eller definierar en output som enda argument, t.ex.

```
./build.sh ~/saanghaefte.pdf
```

## Lägg till en visa

_PRs welcome!_

För att lägga till en låt behöver du bara göra följande

1. Lägg till en Markdown-fil med din visa, t.ex. `mariagartilllophtet.md`
2. Lägg till var i häftet det ska vara i `songorder.txt`