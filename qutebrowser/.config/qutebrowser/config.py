config.load_autoconfig()

#c.zoom.default = '125%'

## external editor for ctrl-e
c.editor.command = [ 'emacsclient', '-c', '{}' ]

## hide tabs most of the time
c.tabs.show = 'switching'

## restrict content
c.content.javascript.enabled = False
c.content.images = False

## alias key everywhere
c.bindings.key_mappings = {
  '<ctrl-g>': '<escape>'
}

## make ctrl-x a prefix
config.unbind('<ctrl-x>')
config.bind('<ctrl-x><ctrl-c>', 'quit')

## tabs
config.bind('<ctrl-x>k', 'tab-close')
config.bind('x', 'tab-close')
config.bind('X', 'undo')

config.bind('<alt-w>', 'yank')
config.bind('<alt-x>', 'set-cmd-text :')
config.bind('<ctrl-x>m', 'set-cmd-text :')
config.bind('<ctrl-x><u>', 'undo')
config.bind('<ctrl-x><ctrl-c>', 'quit')

config.bind('<', 'scroll-to-perc 0')
config.bind('>', 'scroll-to-perc 100')

## movement keys in normal mode
config.bind('<ctrl-n>', 'fake-key <Down>', mode='normal')
config.bind('<ctrl-p>', 'fake-key <Up>', mode='normal')

## command mode
config.bind('<ctrl-p>', 'completion-item-focus --history prev', mode='command')
config.bind('<ctrl-n>', 'completion-item-focus --history next', mode='command')

## prompt mode
config.bind('<ctrl-p>', 'prompt-item-focus prev', mode='prompt')
config.bind('<ctrl-n>', 'prompt-item-focus next', mode='prompt')

## scroll half page
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')

## buffers/tabs
config.bind('<ctrl-t>', 'set-cmd-text -s :tab-select')
config.bind('<ctrl-x>b', 'set-cmd-text -s :buffer')
config.bind('<ctrl-i>', 'set-cmd-text -s :open')
config.bind('<ctrl-Down>', 'tab-next')
config.bind('<ctrl-Up>', 'tab-prev')

## search
config.bind('<ctrl-s>', 'set-cmd-text /', mode='normal')
config.bind('<ctrl-r>', 'set-cmd-text ?', mode='normal')
config.bind('<ctrl-s>', 'search-next', mode='command')
config.bind('<ctrl-r>', 'search-prev', mode='command')

## help
config.bind('<ctrl-x>b', 'open qute://bindings/')
config.bind('<ctrl-h><ctrl-h>', 'set-cmd-text -s :help')

## page color scheme
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.prefers_color_scheme_dark = True

## ui colors
c.colors.webpage.bg = 'Black'

c.colors.statusbar.url.success.http.fg = 'IndianRed'
c.colors.statusbar.url.success.https.fg = 'PaleGreen'

c.colors.completion.item.selected.fg = '#838b8b' # azure4
c.colors.completion.item.selected.bg = 'MidnightBlue'
c.colors.completion.item.selected.border.bottom = 'MidnightBlue'
c.colors.completion.item.selected.border.top = 'MidnightBlue'

c.colors.completion.fg = '#838b8b'
c.colors.completion.odd.bg = 'Black'
c.colors.completion.even.bg = 'Black'
c.colors.completion.category.fg = '#458b74'
c.colors.completion.category.bg = '#222222'

c.colors.hints.bg = 'Black'
c.colors.hints.fg = 'IndianRed'
c.colors.hints.match.fg = 'PaleGreen'

c.hints.chars = 'arstneiofudh'
c.hints.border = '0px'

c.colors.tabs.even.bg = 'Black'
c.colors.tabs.even.fg = 'grey'
c.colors.tabs.odd.bg = 'Black'
c.colors.tabs.odd.fg = 'grey'

c.colors.tabs.selected.even.bg = 'Black'
c.colors.tabs.selected.even.fg = 'cyan'
c.colors.tabs.selected.odd.bg = 'Black'
c.colors.tabs.selected.odd.fg = 'cyan'

c.fonts.default_family = 'Roboto Mono'
c.fonts.default_size = '11pt'

c.fonts.web.family.standard = 'Source Sans Pro'
c.fonts.web.family.sans_serif = 'Source Sans Pro'
c.fonts.web.family.serif = 'Source Serif Pro'
c.fonts.web.family.fixed = 'Roboto Mono'
