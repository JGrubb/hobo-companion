jQuery ($) ->
  chartMargin =
    top: 20
    right: 0
    bottom: 30
    left: 50
  positionChart = ->
    drawChart = (data) ->
      m = chartMargin
      @width = $('#position-chart').width()
      @height = Math.floor(@width / 1.618)
      @w = @width - m.left - m.right
      @h = @height - m.top - m.bottom
      x = d3.scale.linear().domain([0, d3.max((d) -> d.position)]).range [0, @w]
      y = d3.scale.linear().domain([0, d3.max((d) -> d.count)]).range [@h, 0]
      xAxis = d3.svg.axis().scale(x).orient "bottom"
      yAxis = d3.svg.axis().scale(y).orient "left"
      svg = d3.select("#position-chart").append("svg")
        .attr("width", @width)
        .attr("height", @height)
    d3.json "/songs/position_info/#{HOBO.song_id}", (err, data) ->
      drawChart data

  

  positionChart() if document.querySelector('#position-chart')
  
  playsPerYear = ->

  showsPerYear = ->
    parseMonth = d3.time.format('%Y-%m').parse
    parseYear  = d3.time.format('%Y').parse
    formatDate = d3.time.format("%Y")
    draw = (data) ->
      period = ""
      data.forEach (d) ->
        if d.month
          d.date = parseMonth "#{d.year}-#{d.month}"
          period = "Month"
        else
          d.date = parseYear "#{d.year}"
          period = "Year"
      "use strict"
      console.log data
      tooltip = d3.select("#shows-per-year").append("div").attr("class", "tooltip").style("opacity", 0)
      divWidth = $('#shows-per-year').width()
      margin = 50
      width = divWidth - margin
      height = (divWidth / 1.618 / 2) - margin
      count_extent = d3.extent(data, (d) ->
        d.count
      )
      time_extent = d3.extent(data, (d) ->
        d.date
      )
      count_scale = d3.scale.linear().domain(count_extent).range([height, margin])
      time_scale = d3.time.scale().domain(time_extent).range([margin, width])
      time_axis = d3.svg.axis().scale(time_scale)
      count_axis = d3.svg.axis().scale(count_scale).orient("left")
      line = d3.svg.line().x((d) ->
        time_scale d.date
      ).y((d) ->
        count_scale d.count
      ).interpolate("linear")
      d3.select("#shows-per-year").append("svg").attr("class", "chart").attr("width", width + margin).attr "height", height + margin
      d3.select("svg").append("path").attr("d", line(data)).attr "class", "grand_central"
      d3.select("svg").selectAll("circle").data(data).enter().append("circle")
      d3.selectAll("circle").attr("cy", (d) ->
        count_scale d.count
      ).attr("cx", (d) ->
        time_scale d.date
      ).attr("r", 4).on("mouseover", (d) ->
        tooltip.transition().duration(300).style("opacity", 0.9)
        tooltip.html("#{formatDate d.date} <br /> # of shows: #{d.count}")
          .style("left", "#{d3.event.pageX - 100}px")
          .style("top", "#{d3.event.pageY - 28}px")
      ).on("mouseout", (d) ->
        tooltip.transition().duration(300).style("opacity", 0)
      )
      d3.select("svg").append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call time_axis
      d3.select("svg").append("g").attr("class", "y axis").attr("transform", "translate(" + margin + ",0)").call count_axis
      d3.select(".y.axis").append("text").text("Number of Shows").attr("transform", "rotate (90, " + -margin + ", 0)").attr("x", 20).attr "y", 0
      d3.select(".x.axis").append("text").text("#{period}").attr("x", ->
        (width / 1.6) - margin
      ).attr "y", margin / 1.5
    d3.json "/shows/shows_per_year", draw
  showsPerYear() if document.querySelector('#shows-per-year')