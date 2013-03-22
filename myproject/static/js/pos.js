$(function() {
  $('input:checkbox').bind('change',function() {
    $('#'+this.id+'_lb').toggle($(this).is(':checked'));
  });
 
 /* $("#pay").click(function() {
    $("#bill input[type=checkbox]").each(function() {
      if($(this).is(":checked"))
      {
       $(this).parent().hide();
       $(this).prop('checked', false);
       $('#'+ this.id +'_lb').hide();
     /* 
       var itemsToPayFor = JSON.stringify({
	'table':{% tableNum %},
	'menuItem':'Food'});

       $.post('/payForItems.json', itemsToPayFor, function(data) {
	$('#posForm label[name="testing"]').text("Added stuff");	
       }, "json");
      }
    });
  });*/
});

function payForItems(tableNum) {
	$("#bill input[type=checkbox]").each(function() {
 		if($(this).is(":checked")){
			$(this).parent().hide();
       			$(this).prop('checked', false);
       			$('#'+ this.id +'_lb').hide();

			var itemToPayFor = JSON.stringify({
        			'table':tableNum,
        			'menuItem':this.id});

       			$.post('/payForItems.json', itemToPayFor, function(data) {}, "json");
		}
	});	
}

function displayTableBill(tableNum) {
    $(".tab-pane").hide();
    $("#tableNum" + tableNum).show();
}
