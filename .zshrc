export CHANGELOG_GITHUB_TOKEN=ba921fcdb9d8bd93abd7365fd81fbc548952ea50

autoload -Uz promptinit zmv colors
colors
PROMPT="%(2j.%j jobs are running .%(1j.%j job is running .))%# "
promptinit && prompt bart cyan green yellow red
zstyle ':completion::complete:*' use-cache 1

#export TERM=${TERM:/xterm/xterm-256color} #Workaround Terminal/vte bug/argument.

fpath=(~/.zsh/completion $fpath)

function running_osx() {
  uname -a | grep -qi darwin
}

function running_linux() {
  uname -a | grep -qi linux
}

eval `keychain --eval --quiet --quick`
# function add_all_ssh_keys()
# {
#   ssh-add $(grep -lR PRIVATE ~/.ssh)
#   if [ -n "${TMUX+x}" ]; then
#     tmux set-environment SSH_AGENT_PID $SSH_AGENT_PID
#     tmux set-environment SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   fi
# }
# alias ssh="(ssh-add -l > /dev/null || add_all_ssh_keys ) && ssh"

bindkey -v
bindkey ' ' magic-space
bindkey -v ^R history-incremental-search-backward
bindkey -v ^F history-incremental-search-forward

#autoload predict-on
#zle -N predict-on
#zle -N predict-off
#bindkey '^X^Z' predict-on
#bindkey '^Z' predict-off
#predict-on


### http://www.zsh.org/mla/users/2002/msg00138.html ############
function __up_or_down_line_or_beginning_search {               #
if [[ $LASTWIDGET != down-line-or-beginning-search &&          #
      $LASTWIDGET != up-line-or-beginning-search ]]; then      #
    local LBUFFER_STRIPPED="${LBUFFER/#[       ]#/}"           #
    if [[ $RBUFFER == *$'\n'* ||                               #
          ${LBUFFER_STRIPPED} == "" ]]; then                   #
        __last_up_line=up-line-or-history                      #
        __last_down_line=down-line-or-history                  #
    else                                                       #
        LBUFFER_STRIPPED="${LBUFFER_STRIPPED/#[^   ]#[   ]#/}" #
        if [[ "$LBUFFER_STRIPPED" == "" ]]; then               #
            __last_up_line=up-line-or-search                   #
            __last_down_line=down-line-or-search               #
        else                                                   #
            __last_up_line=history-beginning-search-backward   #
            __last_down_line=history-beginning-search-forward  #
        fi                                                     #
    fi                                                         #
fi                                                             #
}                                                              #
zle -N __up_or_down_line_or_beginning_search                   #
                                                               #
function up-line-or-beginning-search {                         #
    __up_or_down_line_or_beginning_search                      #
    zle .${__last_up_line:-beep}                               #
}                                                              #
                                                               #
function down-line-or-beginning-search {                       #
    __up_or_down_line_or_beginning_search                      #
    zle .${__last_down_line:-beep}                             #
}                                                              #
                                                               #
zle -N up-line-or-beginning-search                             #
zle -N down-line-or-beginning-search                           #
                                                               #
bindkey '[A' up-line-or-beginning-search                     #
bindkey '[B' down-line-or-beginning-search                   #
### http://www.zsh.org/mla/users/2002/msg00138.html ############

setopt always_to_end
setopt auto_cd
setopt auto_pushd
setopt c_bases
setopt nocorrect
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt list_packed
setopt list_rows_first
setopt null_glob
setopt path_dirs
setopt pushd_ignore_dups
setopt pushd_silent
setopt share_history
setopt short_loops

SAVEHIST=100000
HISTSIZE=100000
HISTFILE="${HOME}/.zsh_history"
READNULLCMD=less
REPORTTIME=7

typeset -U PATH="./bin:${HOME}/local/bin:${HOME}/local/sbin:${HOME}/.local/bin:/sbin:/usr/local/bin:/usr/local/sbin:$PATH:./node_modules/.bin"

export LESS="-RXeiF"
export EDITOR="vim"

export ANSIBLE_VAULT_PASSWORD_FILE="${HOME}/.apw"

if running_osx; then
  export LSCOLORS=ExfxcxdxbxExExabagacad
  alias	ls="ls -hFG"
elif running_linux; then
  alias ls="ls -hF --color"
fi

if [[ -d /usr/local/opt/chruby/share/chruby ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
elif [[ -d /usr/share/chruby ]]; then
  source /usr/share/chruby/chruby.sh
  source /usr/share/chruby/auto.sh
fi

alias les="less"
alias	ll="ls -thor"
alias l1="ls -1"
alias	l="ls -1rt"
alias	rm="rm -i"
alias	mv="mv -i"
alias	cp="cp -i"
alias pop="popd"
alias p="pushd"
alias pp="cd ~2"
alias ri="ri -f ansi"
alias h="history"
if running_linux; then
  alias open="xdg-open"
fi
alias e='exec'
alias gst='git status'
alias ta='tmux -2 attach || tn'
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package --all && echo 'vendor/ruby' >> .gitignore"
alias igrep="grep -i"
alias bad="git bisect bad"
alias good="git bisect good"
alias bcps="curl -s bcps.org| hxnormalize -x | hxselect '#status' | w3m -dump -T 'text/html'"
alias v="vim"
alias running-qa-boxes="aws ec2 describe-instances --filters \"Name=tag:role,Values=api-qa\" \"Name=instance-state-name,Values=running\" --query \"Reservations[*].Instances[*].Tags[?Key=='Name'].Value\" --output text"
alias ssh="TERM=xterm-256color ssh"

unused-port-number() {
  ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }'
}

open-tunnel() {
  local env="$1"
  local port_number="$2"
  case $env in
    staging|qa)
      ssh -M -S /tmp/tunnel_${port_number} -NfC -L ${port_number}:balance-staging.crkdkhrqjrq1.us-east-1.rds.amazonaws.com:5432 -o IdentitiesOnly=yes zuul
      ;;
    production)
      ssh -M -S /tmp/tunnel_${port_number} -NfC -L ${port_number}:balance-production.crkdkhrqjrq1.us-east-1.rds.amazonaws.com:5432 -o IdentitiesOnly=yes zuul
      ;;
    *)
      ;;
  esac
}

close-tunnel() {
  local port_number="$1"
  ssh -S /tmp/tunnel_${port_number} -O exit zuul
}

psql-qa() {
  local pr_number=$1
  local port_number=$(unused-port-number)
  open-tunnel qa $port_number
  env PGDATABASE=qa_${pr_number} PGHOST=localhost PGUSER=balance_rails PGPORT=${port_number} PGOPTIONS=--search_path="qa_${pr_number},shared_extensions" psql
  close-tunnel $port_number
}

psql-staging() {
  local tenant="${1:-public}"
  local port_number=$(unused-port-number)
  open-tunnel staging $port_number
  env PGDATABASE=balance_foo PGHOST=localhost PGUSER=balance_rails PGPORT=${port_number} PGOPTIONS=--search_path="${tenant},shared_extensions" psql
  close-tunnel $port_number
}

psql-production() {
  local tenant="${1:-public}"
  local port_number=$(unused-port-number)
  open-tunnel production $port_number
  env PGDATABASE=balance_production PGHOST=localhost PGUSER=balance_rails PGPORT=${port_number} PGOPTIONS=--search_path="${tenant},shared_extensions" psql
  close-tunnel $port_number
}

didi ()
{
   (history 1 | grep -v "didi" | grep "$*") || (grep "$*" $HISTFILE | grep -v didi)
}

order ()
{
   sort $1 | uniq -c | sort -n
}

edit_matches ()
{
  lgrep=$(fc -l -1 | sed 's/ *\([0-9]*\)\(.*\) grep \(.*\)/\2 grep -l \3/')
  vim $(echo $(eval $lgrep)) $*
}

cleanup-git-branches ()
{
  # This is for merge-commit-creating workflows
  local branch=$(git current-branch)
  git br --merged $branch | grep -wv $branch | xargs git br -d
}

cleanup-squashed-github-branches ()
{
  local DELETE
  git br | grep -v -e '*' -e development -e master -e websockets | while read local_branch
  do
    DELETE='n'
    git br -r | grep -q ${local_branch} && echo "${local_branch} exists" || read -q "DELETE?Remove ${local_branch}? "
    [[ ${DELETE} =~ ^[Yy]$ ]] && git br -D ${local_branch}
  done
}

function fix_tmux_env()
{
  # Sometimes my tmux sessions get muddled. I SHOULD find and correct the
  # problem, but for now, exporting these variables fixes it.
  tmux set-environment PATH $PATH
  tmux set-environment GEM_HOME $GEM_HOME
  tmux set-environment GEM_PATH $GEM_PATH
}

function decolor()
{
  sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

function dos2unix()
{
  tr -d '\r'
}

function unix2dos()
{
  sed -e 's,\r*$,\r,'
}

function tarbomb()
{
  [[ $(tar tf "$1" | sed 's,^\./,,' | awk -F/ '{print $1}' | sort | uniq | wc -l) -eq 1 ]] && echo "OK" || echo 'Tarbomb!'
}

function get-tweet() {
  curl -sL $1 | hxnormalize -x | hxselect 'title' | html2text
}

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions '1 '
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' glob '1 '
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute '1 '
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/paul/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function man () {
	env\
          LESS_TERMCAP_mb=$(printf "\e[1;31m")\
          LESS_TERMCAP_md=$(printf "\e[1;31m")\
          LESS_TERMCAP_me=$(printf "\e[0m")\
          LESS_TERMCAP_se=$(printf "\e[0m")\
          LESS_TERMCAP_so=$(printf "\e[1;44;33m")\
          LESS_TERMCAP_ue=$(printf "\e[0m")\
          LESS_TERMCAP_us=$(printf "\e[1;32m")\
          man "$@"
}

function grab_dump_for() {
  client=$1
  file=$(aws s3 ls --human-readable s3://allovue-db-backups/$client | awk 'END { print $NF}')
  aws s3 cp s3://allovue-db-backups/${file} .
}

function prs_since_by() {
  git shortlog --since=$1 --author=$2 | awk '/^ /' | awk '/\(#[0-9]+)$/ {print $NF"|"$0}' | sort -t"|" -k1 | awk -F"|" '{print $NF }'
}

function draft-release-notes () {
  git log $(git describe --tags --abbrev=0)..HEAD --oneline | awk '{$1="###";print $0,"\n"}'
}

autoload -U bashcompinit
bashcompinit
complete -C aws_completer aws

eval "$(fasd --init auto)"
