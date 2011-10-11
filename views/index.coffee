body ->
    h1 'Mecca 〜舞台探訪支援サイト〜'
    div id: 'main', ->
        input type: 'text', id: 'searchbox'
        button id: 'search', -> '検索'
        div id: 'result'
