$(function() {
  $('.tabs a:last').tab('show');

  var numTables = 4;
  for (var currTable = 0; currTable <= numTables; currTable++)
  {
    $('#table' + currTable).tab('show');
    $('#orderlist' + currTable).select2({ width: 'resolve' });
    $('#orderlist' + currTable + ':text').show();
  }
});

function submitOrder(table) {
  var selectMenu = $('#orderlist' + table).val();
  var result = '{ "Orders": [';
  for( var i = 0; i < selectMenu.length; i++)
  {
    if (i != 0)
    {
      result = result + ',';
    }
    result= result + '{ "menuItem":' + selectMenu[i] + ', "tableNum":' + table;
    result= result + ', "groupNum":0, "comments":"' + $('#' + table + '_item'+ selectMenu[i]).val() + '"}';
  }
  result= result + ']}';

  var jsonResult = $.parseJSON(result);
  jsonResult = JSON.stringify(jsonResult);
  $.post('/placedOrder.json', jsonResult, function(data) {
  }, "json");
  alert("Order placed");
}

