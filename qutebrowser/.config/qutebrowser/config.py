config.load_autoconfig()

c.zoom.default = '125%'

config.unbind('<Ctrl-x>')
config.bind('<Ctrl-x><Ctrl-c>', 'quit')

config.bind('<Alt-x>', 'set-cmd-text :')
config.bind('<Alt-w>', 'yank')

config.bind('<Ctrl+n>', 'completion-item-focus next')
config.bind('<Ctrl+n>', 'fake-key <Down>', mode='normal')
config.bind('<Ctrl+p>', 'completion-item-focus prev')
config.bind('<Ctrl+p>', 'fake-key <Up>', mode='normal')
config.bind('<', 'scroll-to-perc 0')
config.bind('>', 'scroll-to-perc 100')

## buffers
config.bind('<Ctrl-t>', 'set-cmd-text -s :buffer')
config.bind('<Ctrl-x>b', 'set-cmd-text -s :buffer')
config.bind('<Ctrl-o>', 'set-cmd-text -s :open')

## tabs
config.bind('<Ctrl-x>k', 'tab-close')
config.bind('x', 'tab-close')
config.bind('X', 'undo')

## esc
config.bind('<Ctrl-g>', 'leave-mode', mode='insert')

## search
config.bind('<Ctrl-s>', 'set-cmd-text /', mode='normal')
config.bind('<Ctrl-r>', 'set-cmd-text ?', mode='normal')
config.bind('<Ctrl-s>', 'search-next', mode='command')
config.bind('<Ctrl-r>', 'search-prev', mode='command')

## colors
c.colors.completion.item.selected.bg = 'MidnightBlue'
c.colors.completion.item.selected.border.bottom = 'MidnightBlue'
c.colors.completion.item.selected.border.top = 'MidnightBlue'
c.colors.completion.fg = 'grey'
c.colors.completion.even.bg = 'Black'
c.colors.completion.odd.bg = 'Black'
c.colors.completion.category.fg = '#458b74'
c.colors.completion.category.bg = '#222222'
