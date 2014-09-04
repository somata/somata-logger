somata = require 'somata'
log = somata.helpers.log

log_client = new somata.Client
logger_log = log_client.remote.bind log_client, 'logger', 'log'

module.exports = slog = ->

    # Parse arguments
    if arguments.length == 2
        [t, s] = arguments
    else if arguments.length == 3
        [t, s, d] = arguments
    else if arguments.length == 4
        [k, t, s, d] = arguments

    # Log to console
    (if k? then log[k] else log) "[#{ t }] #{ s }"

    # Log to logger service
    logger_log
        tag: t
        summary: s
        kind: k
        data: d

# Kind shortcuts
slog.w = -> slog 'w', arguments...
slog.i = -> slog 'i', arguments...
slog.e = -> slog 'e', arguments...
slog.d = -> slog 'd', arguments...
slog.s = -> slog 's', arguments...

