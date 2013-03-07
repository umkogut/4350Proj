$(function() {
  $('.tabs a:last').tab('show');
  var numTables = 4;
  var currTable = 0;

  while (currTable <= numTables)
  {
    currTable++;

    $('#table' + currTable).tab('show');
    $('#orderlist' + currTable).select2({ width: 'resolve' });
  }
});

