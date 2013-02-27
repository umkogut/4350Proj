$(function() {
  var numTables = 4;
  var currTable = 0;
  
  $('.tabs a:last').tab('show');

  while (currTable <= numTables)
  {
    currTable++;
    $('#tableTabs').append($('<li><a href="#table' + currTable + '" data-toggle="tab">Table ' + currTable + '</a></li>'));
    $('#tableOrders').append($('<div class="tab-pane" id="table' + currTable +'"><div class="row-fluid"><div class="span4"><div class="well" id="group1"><input type="text" value="" list="menuItems" id="item1"><datalist id="menuItems>{% for item in menuItems %}<option>{{item.name}}</option>{% endfor %}</datalist></input></div><button class="btn" id="submit">Submit</button></div></div></div>'));
    
    $('#table' + currTable).tab('show');
  }

  var numItems = 1;

  $(document)
    .on('focus', 'input:text', function()
    {
      var $this = $(this);
      if ($this.val() == "")
      {
        numItems++;
        $($this.parent().append($('<input type="text" value ="" list="menuItems" id="item' + numItems + '"><datalist id="menuItems">{% for item in menuItems %}<option>{{item.name}}</option>{% endfor %}</datalist></input>')));
      }
    })
    .on('blur', 'input:text', function()
    {
      var $this = $(this);
      if ($this.val() == "")
      {
        $this.hide();
      }
    });
});
