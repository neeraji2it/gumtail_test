$(function () {
	if ($('#traffic_chart').length > 0) {
		new Morris.Line({
		  element: 'traffic_chart',
		  data: $('#traffic_chart').data('views'),
		  xkey: 'created_at',
		  ykeys: ['view'],
		  labels: ['Total Views'],
		  lineColors: ['#000'],
          pointFillColors: ['#fff'],
          pointStrokeColors: ['#000']
		});
	} 
	else if ($('#orders_chart').length > 0){
		new Morris.Line({
		  element: 'orders_chart',
		  data: $('#orders_chart').data('orders'),
		  xkey: 'created_at',
		  ykeys: ['price'],
		  labels: ['Total price'],
		  preUnits: '$',
		  lineColors: ['#000'],
          pointFillColors: ['#fff'],
          pointStrokeColors: ['#000']
		});
	}
	
});