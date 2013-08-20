jQuery ($) ->
  positionChart = ->
    $chartDiv = $('#position-chart')
    margin =
      top: 20
      right: 0
      bottom: 30
      left: 50
    divWidth = $chartDiv.width()
    divHeight = Math.floor(divWidth * 0.6)
    width = divWidth - margin.left - margin.right
    height = divHeight - margin.top - margin.bottom


  positionChart() if document.querySelector('#position-chart')
  
  playsPerYear = ->

  showsPerYear = ->
    $chartDiv = $('#shows-per-year')
    margin =
      top: 20
      right: 0
      bottom: 30
      left: 50
    divWidth = $chartDiv.width()
    divHeight = Math.floor(divWidth * 0.6)
    width = divWidth - margin.left - margin.right
    height = divHeight - margin-top - margin.bottom
    x = d3.scale.ordinal().rangeBands [0, width]
    y = d3.scale.linear().range [height, 0]
    
    d3.json "/shows/shows_by_year", (error, data) ->
      console.log data
      line = d3.svg.line()
        .x((d, i) -> x(i))
        .y((d) -> y(d.count))

      graph.select('#shows-per-year').append("svg:svg")
        .attr("width", width)
