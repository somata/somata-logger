somata = require 'somata'
log = somata.helpers.log

log_client = new somata.Client
logger_log = log_client.remote.bind log_client, 'logger', 'log'

joinTag = (T, t) -> "#{ T }.#{ t }"

module.exports = slog = ->

    # Parse arguments
    if arguments.length == 2
        [t, s] = arguments
    else if arguments.length == 3
        [t, s, d] = arguments
    else if arguments.length == 4
        [k, t, s, d] = arguments

    t = joinTag(slog.TAG, t) if slog.TAG?

    # Log to console
    (if k? then log[k] else log) "[#{ t }] #{ s }"

    # Log to logger service
    logger_log
        tag: t
        summary: s
        kind: k
        data: d

args3 = (_args) ->
    args = Array::slice.call(_args, 0)
    while args.length < 3
        args.push null
    return args

# Kind shortcuts
slog.w = -> slog 'w', args3(arguments)...
slog.i = -> slog 'i', args3(arguments)...
slog.e = -> slog 'e', args3(arguments)...
slog.d = -> slog 'd', args3(arguments)...
slog.s = -> slog 's', args3(arguments)...

