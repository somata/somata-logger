# Rendering logs
# ------------------------------------------------------------------------------

showLog = (log) ->
    $('#logs').prepend renderLog log

renderLog = (log) ->
    $log_view = $("<div class='log'>")
    $log_view.addClass(log.kind) if log.kind?

    $desc_view = $("<div class='desc'></div>")
    $log_view.append $desc_view

    # Description elements
    $desc_view.append $("<span class='tag'>#{ log.tag }</span>")
    $desc_view.append $("<span class='summary'>#{ log.summary }</span>")
    $desc_view.append $("<span class='time'>#{ new Date() }</span>")

    # Set up a JSONView of the data
    if log.data?
        $data_view = $($("<div class='data'>").JSONView(log.data, collapsed: true))
        $data_view.JSONView 'expand', 1
        $log_view.append $data_view

        # Toggle data view when clicked
        toggleData = -> $log_view.find('.data').toggle()
        h('click', $desc_view).each toggleData

    return $log_view

# Caching
# ------------------------------------------------------------------------------

cached = []

# Caching new logs (prevent re-caching if being re-fed)
cacheLog = (log) ->
    return if log._cached
    log._cached = true
    cached.push log

# Re-feeding the log stream cached logs
feedCached = -> logs.write _cached for _cached in cached

# Filtering
# ------------------------------------------------------------------------------

# Filter log items based on tag
filterTag = (log) -> log.tag.match tag_filter

# Start with the tag filter as the querystring
tag_filter = window.location.search.substr(1)

renderFilter = (filter) -> $('#filter').val filter
renderFilter tag_filter

# Re-filter when the filter input changes
h('change', $('#filter')).each ->
    tag_filter = $('#filter').val()
    reFilter()

# Re-filter by clearing the view and re-reading cached logs
reFilter = ->
    emptyLogs()
    feedCached()

emptyLogs = -> $('#logs').empty()

# Going
# ------------------------------------------------------------------------------

# TODO:
#   * Make wildcard event matcher in somata
#   * Add eventStream option to include event type in callback
#   * Use event type as label for logs

# Read in everything from logger service
logs = eventStream('logger', '*')

logs
    .doto(cacheLog)
    .filter(filterTag)
        .doto(showLog)
    .resume()

