somata-logger
=============

Logger service and a client helper library to publish to this service.

## Usage

Require the client library and give it a convenient name:

```coffee
slog = require 'somata-logger'
```

Basic tagged output:

```coffee
# Arguments: tag, string
slog 'doSomething', "Something was done."
```

Tagged output with data:

```coffee
# Arguments: tag, string, data
slog 'getSomething', "Something was gotten: #{ something.id }", something
```

Use `.s`, `.i`, `.d`, `.e`, `.w` for success, info, debug, error, and warning log "kinds":

```coffee
slog.s 'somethingHappened', "Something good happened"
slog.e 'somethingHappened', "Something terrible happened"
```
