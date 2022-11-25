# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Cookies / Headers
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Enable dark mode
config.set('colors.webpage.preferred_color_scheme', 'dark')

# Caret
config.bind('<j>', 'scroll left')
config.bind('<k>', 'scroll down')
config.bind('<l>', 'scroll up')
config.bind('<;>', 'scroll right')

# Tab
config.bind('<Alt-q>', 'tab-close')
config.bind('<Alt-;>', 'tab-next')
config.bind('<Alt-j>', 'tab-prev')

# Other
config.bind('<Ctrl-r>', 'reload')

