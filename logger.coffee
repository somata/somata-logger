somata = require 'somata'

logger = new somata.Service 'logger',

    log: (v, cb) ->
        # TODO: Real wildcards
        logger.publish '*', v

        cb null, 'ok'

