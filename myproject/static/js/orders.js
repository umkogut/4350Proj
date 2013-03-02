$(function() {
        $(".appetizer").change(function() {
                if ($('.appetizer:checked').length == $('.appetizer').length) {
                        $('.entree').attr("disabled", false);

                        if ($('.entree:checked').length == $('.entree').length) {
                                $('.dessert').attr("disabled", false);
                        }
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


$('#test').click(function() {
	alert("test");
	$.post('getOrders.json', function(data) {
		$('#tableNums').empty();
		$('#tableContent').empty();
		$.each(data, function(table, orders){
			$('#tableNums').append('<li><a href="#' + table + '" data-toggle="tab">' + table + '</a></li>');
			$('#tableContent').append('<div class="tab-pane active" id="' + table + '"><form><fieldset><legend>' + table + '</legend><div class="container-fluid"><div class="row-fluid"><div class="span4"><dl><dt>Appetizers</dt>');
			$.each(orders, function(key, value) {
				if (key == 'category' && value == 'Appetizers') {
					$('#tableContent').append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="' + orders.menuName + '">' + orders.menuName + '</label></dd>');
				}
			});
			$('#tableContent').append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Entrees</dt>');
			$.each(orders, function(key, value) {
				if (key == 'category' && value == 'Entrees') {
					$('#tableContent').append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.menuName + '" disabled="false">' + orders.menuName + '</label></dd>');
				}
			});
			$('#tableContent').append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Dessert</dt>');
			$.each(orders, function(key, value) {
				if (key == 'category' && value == 'Dessert') {
					$('#tableContent').append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.menuName + '" disabled="false">' + orders.menuName + '</label></dd>');
				}
			});
			$('#tableContent').append('</dl></div> <!-- span4 --></div> <!-- row-fluid --><button type="submit" class="btn">Submit</button></div> <!-- container-fluid --></fieldset></form></div>');
		});
	}, "json");
});
