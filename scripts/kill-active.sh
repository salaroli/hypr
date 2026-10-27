#!/bin/sh
# SUPER+Q: fecha a janela ativa.
#
# Programas do Wine (e o gamescope que roda jogos do Wine) não atendem o
# pedido de fechar: o Hyprland mostra "Application Not Responding" e, mesmo
# no "Terminate", o winedevice.exe fica vivo para sempre, preso esperando um
# wineserver que já morreu (só sai com SIGKILL).
#
# Então: pede para fechar como sempre; se a janela é do Wine/gamescope e
# ainda existe depois de $ESPERA s, mata o processo e tudo do mesmo
# WINEPREFIX.
ESPERA=2

janela=$(hyprctl activewindow -j)
addr=$(printf '%s' "$janela" | jq -r '.address // empty')
pid=$(printf '%s' "$janela" | jq -r '.pid // empty')
classe=$(printf '%s' "$janela" | jq -r '.class // empty')
[ -n "$addr" ] || exit 0

hyprctl dispatch killactive >/dev/null

ambiente() { tr '\0' '\n' <"/proc/$1/environ"; } 2>/dev/null

prefixo=$(ambiente "$pid" | sed -n 's/^WINEPREFIX=//p')
exe=$(readlink "/proc/$pid/exe" 2>/dev/null)
case "$classe:$exe" in
  gamescope:*|*:*wine*) ;;
  *) exit 0 ;;  # só Wine e gamescope; o resto fecha do jeito normal
esac

sleep "$ESPERA"
hyprctl clients -j | jq -e --arg a "$addr" 'any(.address == $a)' >/dev/null || exit 0

kill -9 "$pid" 2>/dev/null
if [ -z "$prefixo" ]; then
  # gamescope sem WINEPREFIX: o gamescopereaper derruba os filhos
  [ "$classe" = gamescope ] && exit 0
  prefixo="$HOME/.wine"
fi
WINEPREFIX="$prefixo" wineserver -k 2>/dev/null
sleep 1
for p in $(pgrep -u "$(id -u)"); do
  [ "$p" = $$ ] && continue
  if ambiente "$p" | grep -qx "WINEPREFIX=$prefixo"; then
    kill -9 "$p" 2>/dev/null
  elif [ "$prefixo" = "$HOME/.wine" ] && ! ambiente "$p" | grep -q '^WINEPREFIX=' \
       && { tr '\0' ' ' <"/proc/$p/cmdline"; } 2>/dev/null | grep -q '^[A-Za-z]:\\'; then
    # prefixo padrão: processos do Wine sem WINEPREFIX (cmdline "C:\...")
    kill -9 "$p" 2>/dev/null
  fi
done
exit 0
