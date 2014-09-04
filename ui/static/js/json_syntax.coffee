window.syntaxHighlight = (json) ->
    json_view = $("<div class='rsp line'>").JSONView json, collapsed: true
    $(json_view).JSONView 'expand', 1
    return json_view

