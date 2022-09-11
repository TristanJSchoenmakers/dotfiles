# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Which cookies to accept.
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept.
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

# User agent to send.
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')

# User agent to send.
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
config.set('content.javascript.enabled', True, 'qute://*/*')

# Enable dark mode
# config.set("colors.webpage.darkmode.enabled", True)

config.bind('<Alt-q>', 'tab-close')

config.bind('<Alt-l>', 'tab-next')

config.bind('<Alt-h>', 'tab-prev')
