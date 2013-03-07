$(document).ready(function() {
	$.post('getOrders.json', function(data) {
		var orderList = $.parseJSON(data);
		$('#tableNums').empty();
		$('#tableContent').empty();
		$.each(orderList, function(tableNum, orders){
			$('#tableNums').append('<li><a href="#' + tableNum + '" data-toggle="tab">' + tableNum + '</a></li>');
			$('#tableContent').append('<div class="tab-pane" id="' + tableNum + '"><form><fieldset><legend>' + tableNum + '</legend><div class="container-fluid"><div class="row-fluid"><div class="span4"><dl><dt>Appetizers</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Appetizers'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + order.menuName + '">' + order.menuName + '</label></dd>');
						else
							 $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + order.menuName + '" checked>' + order.menuName + '</label></dd>');
					}
				});
			else {
				if (orders.category == 'Appetizers'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + orders.menuName + '">' + orders.menuName + '</label></dd>');
					else
						 $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + orders.menuName + '" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Entrees</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Entrees'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.menuName + '" disabled="true">' + order.menuName + '</label></dd>');
						else
							$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.menuName + '" disabled="true" checked>' + order.menuName + '</label></dd>');
					}
				});
			else {
				if (orders.category == 'Entrees'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.menuName + '" disabled="true">' + orders.menuName + '</label></dd>');
					else
						$('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.menuName + '" disabled="true" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Dessert</dt>');
			if (orders.constructor == Array)
				$.each(orders, function(table, order) {
					if (order.category == 'Dessert'){
						if (order.isComplete == "False")
							$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.menuName + '" disabled="true">' + order.menuName + '</label></dd>');
						else
							$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.menuName + '" disabled="true"checked>' + order.menuName + '</label></dd>');
					}
				});
			else{
				if (orders.category == 'Dessert'){
					if (order.isComplete == "False")
						$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.menuName + '" disabled="true">' + orders.menuName + '</label></dd>');
					else
						$('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.menuName + '" disabled="true" checked>' + orders.menuName + '</label></dd>');
				}
			}
			$('#'+tableNum).children().children().children().eq(1).append('</dl></div> <!-- span4 --></div> <!-- row-fluid --><button type="submit" class="btn">Submit</button></div> <!-- container-fluid --></fieldset></form></div>');
		});
	}, "json");
});

$(function() {
	$(".appetizer").change(function() {
                if ($('.appetizer:checked').length == $('.appetizer').length) {
                        $('.entree').attr("disabled", false);
                        if ($('.entree:checked').length == $('.entree').length)
                                 $('.dessert').attr("disabled", false);
                } else {                                                                                                           
                        $('.entree').attr("disabled", true);
                        $('.dessert').attr("disabled", true);
                }                                                                                                                  
         });
        $(".entree").change(function() {
                if ($('.entree:checked').length == $('.entree').length) {
                        $('.dessert').attr("disabled", false);
                 } else {
                        $('.dessert').attr("disabled", true);
                }
         });
});

