body ->
    div id: 'root', ->
        h1 id: 'logo', -> 'Mecca 〜舞台探訪支援サイト〜'
        div id: 'search', ->
            input type: 'text', id: 'searchbox'
            button id: 'search', -> '検索'
        div id: 'result'
