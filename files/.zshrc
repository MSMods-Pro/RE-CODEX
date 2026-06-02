ZSH_THEME="codex"

if [ -d "/data/data/com.termux/files/usr/" ]; then
    export ZSH=$HOME/.oh-my-zsh
    TOOLX_DIR="$HOME/.toolx"
    D1="$HOME/.termux"
    PLUGINS_DIR="/data/data/com.termux/files/home/.oh-my-zsh/plugins"
    alias rd='termux-reload-settings'
else
    export ZSH=$HOME/.oh-my-zsh
    TOOLX_DIR="$HOME/.toolx"
    D1="$HOME/.CODEX"
    PLUGINS_DIR="$HOME/.oh-my-zsh/plugins"
    alias rd='source ~/.zshrc 2>/dev/null'
fi

plugins=(git)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source "$ZSH/oh-my-zsh.sh" >/dev/null 2>&1
fi

if [ -f "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" >/dev/null 2>&1
fi

if [ -f "$PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >/dev/null 2>&1
fi

if command -v lsd >/dev/null 2>&1; then
alias la='lsd -l --blocks size,name --color always | column -c $(tput cols)'
alias ls='lsd -l --blocks size,name --color always'
alias lt='lsd --tree --blocks size,name --color always --icon always'
fi

[ -f "$TOOLX_DIR/chat" ]    && alias chat="$TOOLX_DIR/chat"
[ -f "$TOOLX_DIR/unstall" ] && alias unstall="$TOOLX_DIR/unstall"
[ -f "$TOOLX_DIR/dev" ]     && alias dev="$TOOLX_DIR/dev"
[ -f "$TOOLX_DIR/dev" ]     && alias report="$TOOLX_DIR/dev"
[ -f "$TOOLX_DIR/update" ]  && alias update="$TOOLX_DIR/update"
[ -f "$TOOLX_DIR/bname" ]   && alias bname="$TOOLX_DIR/bname"
[ -f "$TOOLX_DIR/help" ]    && alias help="$TOOLX_DIR/help"
[ -f "$TOOLX_DIR/banner" ]  && alias banner="$TOOLX_DIR/banner"
[ -f "$TOOLX_DIR/btheme" ]  && alias btheme="$TOOLX_DIR/btheme"
[ -f "$TOOLX_DIR/sysinfo" ] && alias sysinfo="$TOOLX_DIR/sysinfo"

# ─── Colors ────────────────────────────────────────────────────────────────
r='\033[91m'
p='\033[1;95m'
y='\033[93m'
g='\033[92m'
n='\033[0m'
b='\033[94m'
c='\033[96m'
w='\033[97m'
o='\033[38;5;208m'
lp='\033[38;5;141m'
teal='\033[38;5;49m'

# ─── Symbols ───────────────────────────────────────────────────────────────
X='\033[1;92m[\033[1;00m⎯꯭̽𓆩\033[1;92m]\033[1;96m'
D='\033[1;92m[\033[1;00m〄\033[1;92m]\033[1;93m'
E='\033[1;92m[\033[1;00m×\033[1;92m]\033[1;91m'
A='\033[1;92m[\033[1;00m+\033[1;92m]\033[1;92m'
C='\033[1;92m[\033[1;00m</>\033[1;32m]\033[1;92m'
lm='\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'
dm='\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'
aHELL="\uf489"
USER="\uf007"
TERMINAL="\ue7a2"
PKGS="\uf8d6"
UPT="\uf49b"
CAL="\uf073"
STAR="\uf005"
BOLT="\uf0e7"
SHIELD="\uf132"
FIRE="\uf06d"
GHOST="\uf6e2"
CROWN="\uf521"
ZAP="\uf0e7"
SWORD="\uf6de"
DIAMOND="\uf219"

bol='\033[1m'
bold="${bol}\e[4m"
THRESHOLD=100

# ─── Banner Style Preference ───────────────────────────────────────────────
# Saved in D1/banner_style.txt (1-6). Default: random each session.
BANNER_STYLE_FILE="$D1/banner_style.txt"
if [ -f "$BANNER_STYLE_FILE" ]; then
    CODEX_BANNER_STYLE=$(cat "$BANNER_STYLE_FILE" 2>/dev/null)
else
    CODEX_BANNER_STYLE=$(( (RANDOM % 6) + 1 ))
fi

# ─── Disk Usage ────────────────────────────────────────────────────────────
check_disk_usage() {
    local threshold=${1:-$THRESHOLD}
    local total_size used_size disk_usage
    total_size=$(df -h "$HOME" | awk 'NR==2 {print $2}')
    used_size=$(df -h "$HOME" | awk 'NR==2 {print $3}')
    disk_usage=$(df "$HOME" | awk 'NR==2 {print $5}' | sed 's/%//g')
    if [ -z "$disk_usage" ]; then disk_usage=0; fi
    if [ "$disk_usage" -ge "$threshold" ]; then
        echo -e " ${g}[${n}\uf0a0${g}] ${r}WARN: ${c}Disk Full ${g}${disk_usage}% ${c}| ${c}U${g}${used_size} ${c}of ${c}T${g}${total_size}"
    else
        echo -e " ${g}[${n}\uf0e7${g}] ${c}Disk usage: ${g}${disk_usage}% ${c}| ${c}U${g}${used_size} ${c}of ${c}T${g}${total_size}"
    fi
}

# ─── Username Helper ───────────────────────────────────────────────────────
get_username() {
    local ufile
    if [ -d "/data/data/com.termux/files/usr/" ]; then
        ufile="$HOME/.termux/usernames.txt"
    else
        ufile="$HOME/.CODEX/usernames.txt"
    fi
    if [ -f "$ufile" ]; then cat "$ufile"; else echo "CODEX"; fi
}

# ═══════════════════════════════════════════════════════════════════════════
#  BANNER STYLES
# ═══════════════════════════════════════════════════════════════════════════

# ── Banner 1 : Original Block Style (yellow→cyan gradient) ─────────────────
banner_style1() {
    echo
    echo -e "    ${y}░█████╗░░█████╗░██████╗░███████╗██╗░░██╗"
    echo -e "    ${y}██╔══██╗██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝"
    echo -e "    ${y}██║░░╚═╝██║░░██║██║░░██║█████╗░░░╚███╔╝░"
    echo -e "    ${c}██║░░██╗██║░░██║██║░░██║██╔══╝░░░██╔██╗░"
    echo -e "    ${c}╚█████╔╝╚█████╔╝██████╔╝███████╗██╔╝╚██╗"
    echo -e "    ${c}░╚════╝░░╚════╝░╚═════╝░╚══════╝╚═╝░░╚═╝${n}"
    echo -e "    ${y}╔═══════════════════════╗"
    echo -e "    ${y}║  ${g}〄 ${c}RE-CODEX ${y}〄 ${y}║"
    echo -e "    ${y}╚═══════════════════════╝${n}"
    echo
    echo -e "${b}╭═══════════════════════════════════════⊷"
    echo -e "${b}┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/alphacodex369"
    echo -e "${b}┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/MSModsPro"
    echo -e "${b}╰═══════════════════════════════════════⊷"
    echo
    echo -e "${b}╭══ ${g}〄 ${y}ʀᴇ-ᴄᴏᴅᴇx ${g}〄"
    echo -e "${b}┃❁ ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx"
    echo -e "${b}┃❁ ${g}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx"
    echo -e "${b}╰┈➤ ${g}Hey ${y}Dear"
    echo
}

# ── Banner 2 : Slash / Slant ASCII ─────────────────────────────────────────
banner_style2() {
    echo
    echo -e "    ${g}  ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗"
    echo -e "    ${g} ██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝"
    echo -e "    ${teal} ██║     ██║   ██║██║  ██║█████╗   ╚███╔╝ "
    echo -e "    ${teal} ██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗ "
    echo -e "    ${c} ╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗"
    echo -e "    ${c}  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝${n}"
    echo -e "    ${b}  ┌─────────────────────────────────────┐"
    echo -e "    ${b}  │  ${teal}${DIAMOND} ${w}C O D E X  •  T E R M I N A L  ${b}│"
    echo -e "    ${b}  └─────────────────────────────────────┘${n}"
    echo -e "    ${b}  ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx ${g}│ ${c}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx${n}"
    echo
}

# ── Banner 3 : Neon / Flame style ──────────────────────────────────────────
banner_style3() {
    echo
    echo -e "    ${r}  ▄████▄   ▒█████  ▓█████▄ ▓█████ ▒██   ██▒"
    echo -e "    ${r} ▒██▀ ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀ ▒▒ █ █ ▒░"
    echo -e "    ${o} ▒▓█    ▄ ▒██░  ██▒░██   █▌▒███   ░░  █   ░"
    echo -e "    ${o} ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄  ░ █ █ ▒ "
    echo -e "    ${y} ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒▒██▒ ▒██▒"
    echo -e "    ${y} ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░▒▒ ░ ░▓ ░${n}"
    echo -e "    ${r}  ╔══════════════════════════════════╗"
    echo -e "    ${r}  ║  ${o}${FIRE} ${y}CODEX • FLAME EDITION ${r}${FIRE}  ║"
    echo -e "    ${r}  ╚══════════════════════════════════╝${n}"
    echo -e "    ${r}  ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx ${g}│ ${c}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx${n}"
    echo
}

# ── Banner 4 : Matrix / Cyber style ────────────────────────────────────────
banner_style4() {
    echo
    echo -e "    ${g}  ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗"
    echo -e "    ${g} ██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝"
    echo -e "    ${g} ██║     ██║   ██║██║  ██║█████╗   ╚███╔╝ "
    echo -e "    ${g} ██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗ "
    echo -e "    ${g} ╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗"
    echo -e "    ${g}  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝${n}"
    echo -e "    ${g}╔═══════════════════════════════════════════╗"
    echo -e "    ${g}║  ${n}01000011 01001111 01000100 01000101 01011000  ${g}║"
    echo -e "    ${g}╚═══════════════════════════════════════════╝${n}"
    echo -e "    ${g}  ► ${n}CODEX${g} — MATRIX PROTOCOL ACTIVE ◄${n}"
    echo -e "    ${g}  ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx ${g}│ ${c}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx${n}"
    echo
}

# ── Banner 5 : Minimal / Clean ─────────────────────────────────────────────
banner_style5() {
    echo
    echo -e "    ${c} ▄████▄   ▒█████  ██████╗ ███████╗██╗  ██╗"
    echo -e "    ${c}██╔════╝ ██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝"
    echo -e "    ${c}██║      ██║   ██║██║  ██║█████╗   ╚███╔╝ "
    echo -e "    ${b}██║      ██║   ██║██║  ██║██╔══╝   ██╔██╗ "
    echo -e "    ${b}╚██████╗ ╚██████╔╝██████╔╝███████╗██╔╝ ██╗"
    echo -e "    ${b} ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝${n}"
    echo -e "    ${b}  ─────────────────────────────────────────"
    echo -e "    ${b}  ${c}◈ ${w}CODEX  ${c}│  ${g}DX-SIMU  ${c}│  ${y}v2.0${b}  ◈"
    echo -e "    ${b}  ─────────────────────────────────────────${n}"
    echo -e "    ${b}  ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx ${b}│ ${c}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx${n}"
    echo
}

# ── Banner 6 : Royal / Crown style ─────────────────────────────────────────
banner_style6() {
    echo
    echo -e "    ${lp}  ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗"
    echo -e "    ${lp} ██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝"
    echo -e "    ${p} ██║     ██║   ██║██║  ██║█████╗   ╚███╔╝ "
    echo -e "    ${p} ██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗ "
    echo -e "    ${p} ╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗"
    echo -e "    ${lp}  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝${n}"
    echo -e "    ${p}  ╔══════════════════════════════════════╗"
    echo -e "    ${p}  ║  ${lp}${CROWN} ${w}CODEX ROYAL  •  DX-SIMU ${p}${CROWN}  ║"
    echo -e "    ${p}  ╚══════════════════════════════════════╝${n}"
    echo -e "    ${p}  ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴅx-ᴄᴏᴅᴇx ${p}│ ${lp}ʀᴇ-ᴄʀᴇᴀᴛᴏʀ: ${y}ms-ᴄᴏᴅᴇx${n}"
    echo
}

# ─── Active Banner Dispatcher ──────────────────────────────────────────────
banner() {
    command clear
    case "${CODEX_BANNER_STYLE}" in
        1) banner_style1 ;;
        2) banner_style2 ;;
        3) banner_style3 ;;
        4) banner_style4 ;;
        5) banner_style5 ;;
        6) banner_style6 ;;
        *) banner_style1 ;;
    esac
}

# ─── Spin / Loading ────────────────────────────────────────────────────────
spin() {
    command clear
    banner
    local pid=$!
    local delay=0.40
    local spinner=('█■■■■' '■█■■■' '■■█■■' '■■■█■' '■■■■█')
    while ps -p $pid > /dev/null 2>&1; do
        for i in "${spinner[@]}"; do
            tput civis
            echo -ne "\033[1;96m\r [+] Downloading..please wait.........\e[33m[\033[1;92m$i\033[1;93m]\033[1;0m   "
            sleep $delay
            printf "\b\b\b\b\b\b\b\b"
        done
    done
    printf "   \b\b\b\b\b"
    tput cnorm
    printf "\e[1;93m [Done]\e[0m\n"
    echo
    sleep 1
}

# ─── CODEX Server ──────────────────────────────────────────────────────────
if [ -d "$HOME/CODEX" ]; then rm -rf $HOME/CODEX; fi
CODEX="https://codex-server-x.vercel.app"
mkdir -p "$D1"
UPDATE_LOG="$HOME/.codex_update_id.txt"

# ─── Auto Update ───────────────────────────────────────────────────────────
udp() {
    if [ -d "$HOME/CODEX" ]; then rm -rf $HOME/CODEX; fi
    if command -v curl >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
        local update_data=$(curl -s --connect-timeout 3 "$CODEX/update" 2>/dev/null)
        local server_id=$(echo "$update_data" | jq -r '.id' 2>/dev/null | tr -d '[:space:]')
        local server_msg=$(echo "$update_data" | jq -r '.message' 2>/dev/null)
        if [ -n "$server_id" ] && [ "$server_id" != "null" ]; then
            local current_id=""
            if [ -f "$UPDATE_LOG" ]; then
                current_id=$(cat "$UPDATE_LOG" 2>/dev/null | tr -d '[:space:]')
            fi
            if [ "$current_id" != "$server_id" ]; then
                echo "$server_id" > "$UPDATE_LOG"
                banner
                echo -e " ${A} ${c}Tools Updated ${n}| ${c}New ${g}$server_msg"
                sleep 3
                cd "$HOME" || return
                rm -rf RE-CODEX
                git clone https://github.com/MSMods-Pro/RE-CODEX.git >/dev/null 2>&1 &
                spin
                if [ -d "RE-CODEX" ]; then cd RE-CODEX || return; bash install.sh; fi
            fi
        fi
    fi
}

# ─── Session Stats ─────────────────────────────────────────────────────────
SESSION_START_TIME=$(date +%s)

session_uptime() {
    local now elapsed h m s
    now=$(date +%s)
    elapsed=$((now - SESSION_START_TIME))
    h=$((elapsed / 3600))
    m=$(( (elapsed % 3600) / 60 ))
    s=$((elapsed % 60))
    if [ $h -gt 0 ]; then
        echo -e "${c}${h}h ${m}m ${s}s"
    elif [ $m -gt 0 ]; then
        echo -e "${c}${m}m ${s}s"
    else
        echo -e "${c}${s}s"
    fi
}

# ─── Command Counter ───────────────────────────────────────────────────────
CODEX_CMD_COUNT=0
CODEX_CMD_COUNTER_FILE="$D1/.cmd_count"
if [ -f "$CODEX_CMD_COUNTER_FILE" ]; then
    CODEX_CMD_COUNT=$(cat "$CODEX_CMD_COUNTER_FILE" 2>/dev/null || echo 0)
fi

_codex_preexec_counter() {
    CODEX_CMD_COUNT=$((CODEX_CMD_COUNT + 1))
    echo "$CODEX_CMD_COUNT" > "$CODEX_CMD_COUNTER_FILE" 2>/dev/null
}
add-zsh-hook preexec _codex_preexec_counter 2>/dev/null || true

# ─── Network Status Helper ─────────────────────────────────────────────────
net_status() {
    if curl -s --connect-timeout 2 https://github.com >/dev/null 2>&1; then
        echo -e "${g}ONLINE${n}"
    else
        echo -e "${r}OFFLINE${n}"
    fi
}

# ─── IP Info ───────────────────────────────────────────────────────────────
myip() {
    local ip
    ip=$(curl -s --connect-timeout 3 https://api.ipify.org 2>/dev/null)
    if [ -n "$ip" ]; then
        echo -e " ${g}[${n}\uf015${g}] ${c}Public IP: ${g}${ip}${n}"
    else
        echo -e " ${E} ${r}Could not fetch IP (offline?)${n}"
    fi
}
alias ip='myip'

# ─── Weather One-liner ─────────────────────────────────────────────────────
weather() {
    local city="${1:-}"
    if [ -z "$city" ]; then
        curl -s --connect-timeout 5 "wttr.in?format=3" 2>/dev/null || echo -e " ${E} ${r}No network${n}"
    else
        curl -s --connect-timeout 5 "wttr.in/${city}?format=3" 2>/dev/null || echo -e " ${E} ${r}No network${n}"
    fi
}

# ─── Quick Note ────────────────────────────────────────────────────────────
NOTES_FILE="$D1/.codex_notes.txt"
note() {
    if [ -z "$1" ]; then
        if [ -f "$NOTES_FILE" ] && [ -s "$NOTES_FILE" ]; then
            echo -e "\n${b}╭══ ${g}${STAR} ${y}ᴄᴏᴅᴇx ɴᴏᴛᴇs ${b}══⊷"
            local i=1
            while IFS= read -r line; do
                echo -e "${b}┃ ${c}[$i] ${n}$line"
                ((i++))
            done < "$NOTES_FILE"
            echo -e "${b}╰════════════════⊷${n}"
        else
            echo -e " ${D} ${y}No notes yet. Use: ${g}note \"your text\"${n}"
        fi
    elif [ "$1" = "clear" ]; then
        > "$NOTES_FILE"
        echo -e " ${A} ${g}Notes cleared.${n}"
    elif [ "$1" = "del" ] && [ -n "$2" ]; then
        sed -i "${2}d" "$NOTES_FILE" 2>/dev/null
        echo -e " ${A} ${g}Note $2 deleted.${n}"
    else
        echo "$*" >> "$NOTES_FILE"
        echo -e " ${A} ${g}Note saved!${n}"
    fi
}

# ─── Clock Alias ───────────────────────────────────────────────────────────
alias clock='watch -n1 "date +\"%T\" | figlet -f big 2>/dev/null || date"'

# ─── Load / Intro Animation ────────────────────────────────────────────────
load() {
    command clear
    echo -e "${TERMINAL}${r}●${n}"
    sleep 0.2
    command clear
    echo -e "${TERMINAL}${r}●${y}●${n}"
    sleep 0.2
    command clear
    echo -e "${TERMINAL}${r}●${y}●${b}●${n}"
    sleep 0.2
}

# ─── Cursor Helpers ────────────────────────────────────────────────────────
PUT()        { echo -en "\033[${1};${2}H"; }
DRAW()       { echo -en "\033%"; echo -en "\033(0"; }
WRITE()      { echo -en "\033(B"; }
HIDECURSOR() { echo -en "\033[?25l"; }
NORM()       { echo -en "\033[?12l\033[?25h"; }

# ─── Advanced Dashboard ────────────────────────────────────────────────────
draw_dashboard() {
    local data uname_val uptime_str net_str cmd_str
    data=$(check_disk_usage)
    uname_val=$(get_username)
    uptime_str=$(session_uptime)
    cmd_str="${g}${CODEX_CMD_COUNT}${c} cmds"

    local widths
    widths=$(stty size 2>/dev/null | awk '{print $2}')
    if [ -z "$widths" ] || [ "$widths" -lt 10 ]; then widths=$(tput cols 2>/dev/null || echo 80); fi
    local width=$widths
    local var=$((width - 2))
    local var2
    var2=$(printf '═%.0s' $(seq 1 $var))
    local var3
    var3=$(printf ' %.0s' $(seq 1 $var))
    local var4=$((width - 20))
    if [ $var4 -lt 1 ]; then var4=1; fi

    local prefix="${TERMINAL}${r}●${y}●${b}●${n}"
    local clean_prefix
    clean_prefix=$(echo -e "$prefix" | sed 's/\x1b\[[0-9;]*m//g')
    local prefix_len=${#clean_prefix}
    local clean_data
    clean_data=$(echo -e "${data}" | sed 's/\x1b\[[0-9;]*m//g')
    local data_len=${#clean_data}
    local data_start=$(( (width - data_len) / 2 ))
    local padding=$((data_start - prefix_len))
    if [ $padding -lt 0 ]; then padding=0; fi
    local spaces
    spaces=$(printf '%*s' $padding "")

    PUT 1 1
    echo -e "${prefix}${spaces}${data}${c}"

    PUT 2 1
    echo -e "\033[36;1m╔${var2}╗\033[0m"
    for ((i=3; i<=12; i++)); do
        PUT $i 1
        echo -e "\033[36;1m║${var3}║\033[0m"
    done
    PUT 13 1
    echo -e "\033[36;1m╚${var2}╝\033[0m"

    PUT 4 1
    if command -v simu >/dev/null 2>&1; then
        simu -w $width "DX-SIMU" | lolcat -f 2>/dev/null || simu -w $width "DX-SIMU"
    fi

    PUT 2 1
    echo -e "\033[36;1m╔${var2}╗\033[0m"
    for ((i=3; i<=12; i++)); do
        PUT $i 1
        echo -e "\033[36;1m║\033[0m"
        PUT $i $width
        echo -e "\033[36;1m║\033[0m"
    done
    PUT 13 1
    echo -e "\033[36;1m╚${var2}╝\033[0m"

    # Version tag bottom-right
    PUT 12 ${var4}
    echo -e "\e[32m[\e[0m\uf489\e[32m] \e[36mCODEX \e[36mv2.0\e[0m"

    # Session info row
    PUT 11 3
    echo -e " ${g}[${n}${USER}${g}] ${c}${uname_val}  ${g}│ ${y}⏱ ${uptime_str}  ${g}│ ${p}${cmd_str}${n}"

    PUT 14 1
    # Ads / datetime line
    local ads1=""
    if command -v curl >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
        ads1=$(curl -s --connect-timeout 2 "$CODEX/ads" | jq -r '.message' 2>/dev/null)
    fi
    if [ -z "$ads1" ] || [ "$ads1" = "null" ]; then
        local DATE TM
        DATE=$(date +"%Y-%b-%a ${g}—${c} %d")
        TM=$(date +"%I:%M:%S ${g}— ${c}%p")
        echo -e " ${g}[${n}${CAL}${g}] ${c}${TM} ${g}| ${c}${DATE}"
    else
        echo -e " ${g}[${n}${PKGS}${g}] ${c}Ｃｏｄｅｘ: ${g}$ads1"
    fi

    PUT 15 1
    NORM
}

# ─── Smart Clear ───────────────────────────────────────────────────────────
smart_clear() {
    if [ "$1" = "n" ]; then
        command clear
    else
        command clear
        draw_dashboard
    fi
}
alias clear='smart_clear'

# ─── Banner Theme Switcher (interactive) ──────────────────────────────────
# Usage: btheme   → interactive picker
#        btheme 3 → set theme 3 directly
btheme_cmd() {
    local choice
    if [ -n "$1" ] && [[ "$1" =~ ^[1-6]$ ]]; then
        choice="$1"
    else
        command clear
        echo
        echo -e " ${b}╭═══ ${g}${CROWN} ${y}ʙᴀɴɴᴇʀ ᴛʜᴇᴍᴇ ${b}═══⊷"
        echo -e " ${b}┃"
        echo -e " ${b}┃ ${g}[${n}1${g}] ${c}Original     ${y}(Yellow→Cyan Block)"
        echo -e " ${b}┃ ${g}[${n}2${g}] ${c}Slant        ${y}(Green→Teal Clean)"
        echo -e " ${b}┃ ${g}[${n}3${g}] ${c}Flame        ${y}(Red→Orange Neon)"
        echo -e " ${b}┃ ${g}[${n}4${g}] ${c}Matrix       ${y}(Full Green Cyber)"
        echo -e " ${b}┃ ${g}[${n}5${g}] ${c}Minimal      ${y}(Cyan→Blue Clean)"
        echo -e " ${b}┃ ${g}[${n}6${g}] ${c}Royal        ${y}(Purple Crown)"
        echo -e " ${b}┃ ${g}[${n}7${g}] ${c}Random       ${y}(Random every session)"
        echo -e " ${b}╰════════════════════⊷${n}"
        echo
        read -p "$(echo -e ${A}${g}──[${n}Select 1-7${g}]────► ${n})" choice
    fi
    case "$choice" in
        [1-6])
            echo "$choice" > "$BANNER_STYLE_FILE"
            CODEX_BANNER_STYLE="$choice"
            echo -e "\n ${A} ${g}Banner style ${c}$choice${g} saved!${n}"
            sleep 0.5
            banner
            draw_dashboard
            ;;
        7)
            rm -f "$BANNER_STYLE_FILE"
            CODEX_BANNER_STYLE=$(( (RANDOM % 6) + 1 ))
            echo -e "\n ${A} ${g}Random mode enabled!${n}"
            sleep 0.5
            banner
            draw_dashboard
            ;;
        *)
            echo -e " ${E} ${r}Invalid choice.${n}"
            ;;
    esac
}

# ─── Sysinfo Panel ─────────────────────────────────────────────────────────
sysinfo_cmd() {
    local uname_val vendor model os_info kernel shell_v cpu_info ram_total ram_used
    uname_val=$(get_username)
    if command -v getprop &>/dev/null; then
        vendor=$(getprop ro.product.manufacturer 2>/dev/null)
        model=$(getprop ro.product.model 2>/dev/null)
        os_info="Android (Termux)"
    else
        vendor=$(uname -s)
        model=$(uname -n)
        os_info=$(uname -o 2>/dev/null || echo "Linux")
    fi
    kernel=$(uname -r)
    shell_v="$ZSH_VERSION"
    cpu_info=$(grep -m1 "model name" /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs || echo "N/A")
    ram_total=$(free -h 2>/dev/null | awk '/Mem:/{print $2}' || echo "N/A")
    ram_used=$(free -h 2>/dev/null | awk '/Mem:/{print $3}' || echo "N/A")
    local disk_data
    disk_data=$(check_disk_usage)
    local uptime_str
    uptime_str=$(session_uptime)

    command clear
    echo
    echo -e " ${b}╭══════════════════════════════════════════════╗"
    echo -e " ${b}║  ${g}${DIAMOND} ${y}CODEX SYSTEM INFORMATION ${g}${DIAMOND}             ${b}║"
    echo -e " ${b}╠══════════════════════════════════════════════╣"
    echo -e " ${b}║  ${c}${USER}  ${g}User       ${b}: ${w}${uname_val}"
    echo -e " ${b}║  ${c}${CROWN}  ${g}Creator    ${b}: ${w}ᴅx-ᴄᴏᴅᴇx"
    echo -e " ${b}║  ${c}${CROWN}  ${g}Re-Creator ${b}: ${w}ms-ᴄᴏᴅᴇx"
    echo -e " ${b}║  ${c}\uf6c3  ${g}Device   ${b}: ${w}${vendor} ${model}"
    echo -e " ${b}║  ${c}\uf6a6  ${g}OS       ${b}: ${w}${os_info}"
    echo -e " ${b}║  ${c}\uf83c  ${g}Kernel   ${b}: ${w}${kernel}"
    echo -e " ${b}║  ${c}\ue7a2  ${g}Shell    ${b}: ${w}zsh ${shell_v}"
    echo -e " ${b}║  ${c}\uf2db  ${g}CPU      ${b}: ${w}${cpu_info}"
    echo -e " ${b}║  ${c}\uf538  ${g}RAM      ${b}: ${w}${ram_used} / ${ram_total}"
    echo -e " ${b}║  ${c}\uf0a0  ${g}Storage  ${b}: ${disk_data}"
    echo -e " ${b}║  ${c}⏱   ${g}Session  ${b}: ${w}${uptime_str}"
    echo -e " ${b}║  ${c}⌨   ${g}Commands ${b}: ${w}${CODEX_CMD_COUNT}"
    echo -e " ${b}╚══════════════════════════════════════════════╝${n}"
    echo
}

# Register tool aliases (works even if toolx files not present yet)
alias btheme='btheme_cmd'
alias sysinfo='sysinfo_cmd'

# ─── Startup ───────────────────────────────────────────────────────────────
udp
HIDECURSOR
load
command clear
draw_dashboard
