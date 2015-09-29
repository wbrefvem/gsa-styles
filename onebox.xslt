<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
    <head>
      <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" /> -->
      <script src="jquery.js"></script>
      <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->
      <script type="text/javascript" src="jsapi"></script>
      <script type="text/javascript">
        var dataArray = [];
        $.getJSON('http://localhost:8008/socrata/', function(_data, status) {
          $.each(_data['data'], function(index, element) {
            dataArray.push([element[12], element[16]]);
          });
        });
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
          var data = google.visualization.arrayToDataTable(dataArray);
          var options = {
            title: 'Total budgeted amount by year',
            legend: { position: 'none' },
          };
          var chart = new google.visualization.Histogram(document.getElementById('chart_div'));
          chart.draw(data, options);
        }
      </script>
    </head>
    <body>
    <div class="container">
      <h2>My CD Collection</h2>
        <table class="table" border="1">
          <tr bgcolor="#9acd32">
            <th style="text-align:left">Budget Year</th>
            <th style="text-align:left">Total Budgeted Amount</th>
          </tr>
          <xsl:for-each select="response/row/row[budget_year='2016']">
            <tr>
              <td><xsl:value-of select="budget_year"/></td>
              <td><xsl:value-of select="budget_amount"/></td>
            </tr>
          </xsl:for-each>
          <tr><td>Total</td><td><xsl:value-of select="format-number(sum(response/row/row[budget_year='2016']/budget_amount), '$#,###,###,###.##')"/></td></tr>
        </table>
      </div>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
