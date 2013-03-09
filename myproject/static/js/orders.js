$(document).ready(function() {
	$.post('getOrders.json', function(data) {
		var orderList = $.parseJSON(data);
		$('#tableNums').empty();
		$('#tableContent').empty();
		$.each(orderList, function(tableNum, orders){
			$('#tableNums').append('<li><a href="#' + tableNum + '" data-toggle="tab">' + tableNum + '</a></li>');
			$('#tableContent').append('<div class="tab-pane" id="' + tableNum + '"><form c><fieldset><legend>' + tableNum + '</legend><div class="container-fluid"><div class="row-fluid"><div class="span4"><dl><dt>Appetizers</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Appetizers'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + order.groupNum + '">' + order.menuName + '</label></dd>');
						else
							 $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + order.groupNum + '" checked>' + order.menuName + '</label></dd>');
					}
				});
			else {
				if (orders.category == 'Appetizers'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + orders.groupNum + '">' + orders.menuName + '</label></dd>');
					else
						 $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + orders.groupNum + '" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Entrees</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Entrees'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.groupNum + '">' + order.menuName + '</label></dd>');
						else
							$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.groupNum + '" checked>' + order.menuName + '</label></dd>');
					}
				});
			else {
				if (orders.category == 'Entrees'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.groupNum + '">' + orders.menuName + '</label></dd>');
					else
						$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.groupNum + '" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Dessert</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Dessert'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.groupNum + '">' + order.menuName + '</label></dd>');
						else
							$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.groupNum + '" checked>' + order.menuName + '</label></dd>');
					}
				});
			else{
				if (orders.category == 'Dessert'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.groupNum + '">' + orders.menuName + '</label></dd>');
					else
						$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.groupNum + '" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().eq(1).append('</dl></div> <!-- span4 --></div> <!-- row-fluid --><button type="submit" class="btn" id="button">Submit</button></div> <!-- container-fluid --></fieldset></form></div>');
		});
	}, "json");
});

$(document).on('click', '#button', function(){
	alert("I work!");
});


