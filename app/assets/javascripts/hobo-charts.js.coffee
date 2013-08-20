jQuery ($) ->
  positionChart = ->
    $chartDiv = $('#position-chart')
    margin =
      top: 50
      right: 0
      bottom: 30
      left: 50
    divWidth = $chartDiv.width()
    divHeight = Math.floor(divWidth * 0.6)
    width = divWidth - margin.left - margin.right
    height = divHeight - margin.top - margin.bottom
    x = d3.scale.linear().range [0, width]
    y = d3.scale.linear().range [height, 0]
    xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(5)
    yAxis = d3.svg.axis().scale(y).orient("left").ticks(5)
    svg = d3.select('#position-chart').append("svg")
      .attr("width", divWidth)
      .attr("height", divHeight)
      .append("g").attr("transform", "translate(#{margin.left}, #{margin.top})")
      
    d3.json "/songs/position_info/#{HOBO.song_id}", (error, data) ->
      max = d3.max(data, (f) -> return f.count)
      fit = 255 / max
      x.domain data.map (d) -> return d.position
      y.domain [0, d3.max(data, (d) -> return d.count)]
      svg.append("g").attr("class", "x axis")
        .attr("transform", "translate(0, #{height})")
        .attr("display", "none")
        .call xAxis
        
      svg.append("g").attr("class", "y axis")
        .call(yAxis)
        .append("text").attr("transform", "rotate(-90)")
        .attr("y", 5)
        .attr("dy", "-3em")
        .style("text-anchor", "end")
        .text("Number of times played")

      svg.selectAll("bar").data(data).enter().append("rect")
        .attr("class", "bar")
        .attr("x", (d, i) -> return i * (width / data.length))
        .attr("width", Math.floor (width / data.length) - 2)
        .attr("y", (d) -> return y(d.count))
        .attr("fill", (d) ->
          return "rgb(#{Math.floor(d.count * fit)}, 0, 0)")
        .attr("height", (d) -> return height - y(d.count))

        #svg.selectAll("text").data(data).enter().append("text")
        #  .text((d) -> d.count)
        #  .attr("x", (d, i) -> i * (Math.floor(width / data.length)))
        #  .attr("y", height - 10)
        #  .attr("fill", "white")
      
      svg.append("text")
        .attr("x", width / 2)
        .attr("y", 5 - (margin.top / 2))
        .attr("text-anchor", "middle")
        .style("text-decoration", "underline")
        .text("Setlist placement")

  positionChart() if $('#position-chart').length
  
  playsPerYear = ->
    
