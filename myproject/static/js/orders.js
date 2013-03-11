var table;

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
                                                        $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="'+order.orderID+'">' + order.menuName + '</label></dd>');
                                                else
                                                         $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="'+order.orderID+'" checked>' + order.menuName + '</label></dd>');
                                        }
                                });
                        else {
                                if (orders.category == 'Appetizers'){
                                        if (orders.isComplete == "False")
                                                $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="'+orders.orderID+'">' + orders.menuName + '</label></dd>');
                                        else
                                                 $('#'+tableNum).children().children().children().children().children().children().eq(0).append('<dd><label class="checkbox"><input type="checkbox" class="appetizer" id="'+orders.orderID+'" checked>' + orders.menuName + '</label></dd>');
                                }
                        }
                        $('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Entrees</dt>');
                        if (orders.constructor == Array)
                                $.each(orders, function(table, order) {
                                        if (order.category == 'Entrees'){
                                                if (order.isComplete == "False")
                                                        $('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.orderID + '">' + order.menuName + '</label></dd>');
                                                else
                                                        $('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + order.orderID + '" checked>' + order.menuName + '</label></dd>');
                                        }
                                });
                        else {
                                if (orders.category == 'Entrees'){
                                        if (orders.isComplete == "False")
                                                $('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.orderID + '">' + orders.menuName + '</label></dd>');
                                        else
                                                $('#'+tableNum).children().children().children().children().children().children().eq(1).append('<dd><label class="checkbox"><input type="checkbox" class="entree" id="' + orders.orderID + '" checked>' + orders.menuName + '</label></dd>');
                                }
                        }
                        $('#'+tableNum).children().children().children().children().append('</dl></div> <!-- span4 --><div class="span4"><dl><dt>Dessert</dt>');
                        if (orders.constructor == Array)
                                $.each(orders, function(table, order) {
                                        if (order.category == 'Dessert'){
                                                if (order.isComplete == "False")
                                                        $('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.orderID + '">' + order.menuName + '</label></dd>');
                                                else
                                                        $('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + order.orderID + '" checked>' + order.menuName + '</label></dd>');
                                        }
                                });
                        else{
                                if (orders.category == 'Dessert'){
                                        if (orders.isComplete == "False")
                                                $('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.orderID + '">' + orders.menuName + '</label></dd>');
                                        else
                                                $('#'+tableNum).children().children().children().children().children().children().eq(2).append('<dd><label class="checkbox"><input type="checkbox" class="dessert" id="' + orders.orderID + '" checked>' + orders.menuName + '</label></dd>');
                                }
                        }
                        $('#'+tableNum).children().children().children().eq(1).append('</dl></div> <!-- span4 --></div> <!-- row-fluid --><button type="button" class="btn" id="submitBtn" name="submitBtn">Submit</button></div> <!-- container-fluid --></fieldset></form></div>');
                });
        }, "json");
});

$(document).on('shown', '#tableNums', function(e) {
	table = e.target.text;
	$('#result').text("");
	updateCheckbox();
});

$(document).on('change', 'input:checkbox', function() {
	updateCheckbox();
});

$(document).on('click', ':button[name="submitBtn"]', function() {
	var status = '{"orderStatus": [' + getOrderStatus() + ']}';
	alert(status);
	$.post('/orderStatus.json', status, function(data) {
		if(data['isSuccess'])
			$('#result').text('Successfully updated order for "' + table + '"');
	}, "json");
});

function getOrderStatus() {
	var status = $('#' + table + ' input:checkbox').map( function() {
		return '{"orderID": ' + this.id + ', "isComplete": ' + this.checked + '}';
	}).get().join(',');
	return status;
}

function updateCheckbox() {
	if ($('#' + table + ' input:checkbox.appetizer:not(:checked)').length == 0) {
		$('#' + table + ' input:checkbox.entree').attr("disabled", false);
		if ($('#' + table + ' input:checkbox.entree:not(:checked)').length == 0)
			$('#' + table + ' input:checkbox.dessert').attr("disabled", false);
		else
			$('#' + table + ' input:checkbox.dessert').attr("disabled", true);
	}
	else {
		$('#' + table + ' input:checkbox.entree').attr("disabled", true);
		$('#' + table + ' input:checkbox.dessert').attr("disabled", true);
	}
}
