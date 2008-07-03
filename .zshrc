#= zshrc
#= $Id$
unlimit
limit -s
umask 022
bindkey -e

autoload -U zmv
autoload -U zargs
zmodload -i zsh/files

# compinit
fpath=($HOME/.zsh $fpath)
autoload -U compinit
compinit -u

# colors
autoload -U colors
colors

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true

# setopt
setopt autocd
setopt nocorrectall
setopt histignoredups
setopt pushdignoredups
setopt interactivecomments
setopt multios
setopt incappendhistory
setopt autopushd
setopt extendedhistory
setopt extendedglob
setopt noclobber
setopt printeightbit
setopt listpacked
setopt listrowsfirst
setopt cdablevars
unsetopt promptcr
setopt pushd_ignore_dups
setopt extended_glob
setopt extended_history
setopt complete_in_word
setopt menu_complete
setopt multios

# alias
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias gem='nocorrect gem'
alias mkdir='nocorrect mkdir'
alias ll='ls -lh'
alias vi='vim'
alias zmv='noglob zmv'
alias mmv='zmv -W'
alias zcp='zmv -C'
alias zln='zmv -L'
alias memo='vi -c ":HatenaEdit"'
alias 2ch='emacs -f navi2ch'
alias g="gcc -framework OpenGL -framework GLUT -framework Foundation "
alias e='emacsclient -n'
alias s='screen -xRRU -S working_space -t working'
alias d='emacs -f dired'
alias changelog='emacs -f add-change-log-entry-other-window'
alias mew='emacs -f mew'
alias svn='nocorrect svn'

# var
HISTFILE=~/.zsh_history
HISTSIZE=9999999
SAVEHIST=9999999

if [ "$TERM" = "emacs" ]; then
  PROMPT="%n %~[%!]%# "
else
  PROMPT="%n %{$fg[blue]%}%~%{$reset_color%}[%!]%{%(?..$fg[red])%}%#%{$reset_color%} "
fi

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
watch=notme

# env
export PAGER=less
export EDITOR=vi
export LESS="-girMXfFQ"
export LANG=ja_JP.UTF-8
export CLICOLOR=1
export SVN_EDITOR=vim
export PATH="$HOME/bin:$HOME/local/bin:/opt/local/bin:/usr/local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib"
export C_INCLUDE_PATH="$HOME/local/include"
export KEYTIMEOUT=20
export __CF_USER_TEXT_ENCODING='0x1F5:0x08000100:14' # use utf8 with pbcopy/pbpaste 

# chpwd
function chpwd(){ ls }

# known_hosts complete
function print_known_hosts (){ 
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1 
  fi  
}
_cache_hosts=($( print_known_hosts ))

# insert-files
autoload insert-files
zle -N insert-files
bindkey '^X^F' insert-files

# ls-colors
LS_COLORS="fi=37:di=36:ex=32:ln=34:bd=33:cd=33:pi=35:so=35"
LS_COLORS="$LS_COLORS:*.gz=31:*.Z=31:*.lzh=31:*.zip=31:*.bz2=31"
LS_COLORS="$LS_COLORS:*.tar=31:*.tgz=31"
LS_COLORS="$LS_COLORS:*.gif=33:*.jpg=33:*.jpeg=33:*.tif=33:*.ps=33"
LS_COLORS="$LS_COLORS:*.xpm=33:*.xbm=33:*.xwd=33:*.xcf=33"
LS_COLORS="$LS_COLORS:*.avi=33:*.mov=33:*.mpeg=33:*.mpg=33"
LS_COLORS="$LS_COLORS:*.mid=33:*.MID=33:*.rcp=33:*.RCP=33:*.mp3=33"
LS_COLORS="$LS_COLORS:*.mod=33:*.MOD=33:*.au=33:*.aiff=33:*.wav=33"
LS_COLORS="$LS_COLORS:*.htm=35:*.html=35:*.java=35:*.class=32"
LS_COLORS="$LS_COLORS:*.c=35:*.h=35:*.C=35:*.c++=35"
LS_COLORS="$LS_COLORS:*.tex=35:*~=0"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
export LS_COLORS

# history-search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# bindkey -s
bindkey -s "vv" '!vi\n'
bindkey -s "hh" '\C-ucd\n'
bindkey -s "\C-o" '\C-ucd ..\n'

# replace-string
autoload -U replace-string
zle -N replace-string
bindkey "^[r" replace-string

# narrow-to-region
autoload -U narrow-to-region-invisible
zle -N narrow-to-region-invisible
bindkey "\C-xn" narrow-to-region-invisible

# predict on
autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^Z' predict-on
bindkey '^Z' predict-off
zstyle ':predict' verbose true

# url-quote-magic
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# refe
refe(){
  $HOME/utility/refe_utf8.sh $@
}

# for debug
rr() {
  local f
  f=(~/.zsh/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

# load local config
h=${${HOST%%.*}:l}
if [ -f "$HOME/config/hosts/$h.zshrc" ]; then
  source "$HOME/config/hosts/$h.zshrc"
fi

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
