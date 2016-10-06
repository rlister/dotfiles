# unsetopt correct_all            # no spell-correct
# HISTSIZE=10000

SAVEHIST=10000
HISTFILE=~/.zsh_history
WORDCHARS=''                    # meta-move on all non-word chars

setopt no_beep                  # if you beep I will be forced to kill you
setopt interactive_comments     # allow comments in interactive shells
setopt autopushd                # implict pusgd on every dir change
setopt pushd_ignore_dups        # but only one copy of ech dir
setopt hist_ignore_dups         # unique history entries
setopt hist_expire_dups_first   # when trimming history, lose oldest duplicates first
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
unsetopt share_history          # share hist between sessions
setopt extended_history         # save timestamp of command and duration
setopt bang_hist                # !keyword
setopt auto_remove_slash        # space after completed dir removes slash
setopt print_exit_value         # print return value if non-zero
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt nomatch                # makes zsh play nice with square brackets
# setopt auto_menu              # show completion menu on successive tab needs unsetopt menu_complete to work
unsetopt menu_complete          # do not autoselect the first completion entry
# setopt complete_in_word       # allow completion from within a word/phrase
# unsetopt menucomplete automenu # do not do hasty first match insertion on completion
unsetopt SHINSTDIN