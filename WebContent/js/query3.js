google.charts.load('current', { 'packages': ['bar'] });
google.charts.setOnLoadCallback(drawStuff);

function drawStuff() {
    var data = new google.visualization.arrayToDataTable([
        ['Move', 'Percentage'],
        ["1-1-2020", 20],
        ["2-1-2020", 31],
        ["3-1-2020", 12],
        ["4-1-2020", 10],
        ['5-1-2020', 3],
        ['5-1-2020', 3]
    ]);

    var options = {
        width: 550,
        legend: { position: 'none' },
        bar: { groupWidth: "90%" }
    };

    var chart = new google.charts.Bar(document.getElementById('top_x_div'));
    // Convert the Classic options to Material options.
    chart.draw(data, google.charts.Bar.convertOptions(options));
};