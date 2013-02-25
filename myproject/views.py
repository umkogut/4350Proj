import pdb
import transaction;

from pyramid.response import Response
from pyramid.view import view_config
from jinja2 import Environment, FileSystemLoader

from .models import (
    DBSession,
    MenuItem,
    )

@view_config(route_name='add_menu_item', renderer='templates/admin.jinja2')
def add_menu_item(request):
    print request

    params = request.POST
    print params

    itemName = request.params['itemName']
    desc = request.params['desc']
    price = request.params['price']
    vegetarian = "off"
    if 'vegetarian' in params:
       vegetarian = request.params['vegetarian']
    category = request.params['category']

    isVeggie = False

    if vegetarian in ['on']:
       isVeggie = True

    newItem = MenuItem(name=itemName, category=category, price=price, isVegetarian=isVeggie, isActive=True) 
    DBSession.add(newItem)

    transaction.commit()

    return {'project': 'MyProject'}

@view_config(route_name='home', renderer='templates/index.jinja2')
def my_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='menu', renderer='templates/menu.jinja2')
def cook_view(request):
    print request

    print "Loading the menu"
    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
    
    print menuItems

    if menuItems is None:
	print "There is nothing in the menu"

    return {'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='placeOrder', renderer='templates/placeOrder.jinja2')
def placeOrder_view(request):
	print request
	return {'project': 'MyProject'}

@view_config(route_name='orders', renderer='templates/orders.jinja2')
def orders_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='pos', renderer='templates/pos.jinja2')
def pos_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='admin', renderer='templates/admin.jinja2')
def admin_view(request):
    print request
    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()

    return {'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='about', renderer='templates/about.jinja2')
def about_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='test', renderer='templates/test.jinja2')
def test_view(request):
    print request
    return {'project': 'MyProject'}

"""
Keeping this code around temporarily. Will need to look at it later.
Just keep pushing it to the bottom when adding new views
- Marko

@view_config(route_name='fktest', renderer='templates/fktest.jinja2')
def fktest_view(request):
    newTestFK = testFK(fkID=1, testID=1)
    DBSession.add(newTestFK)

    transaction.commit()

    newTestFK2 = testFK(fkID=2, testID=2)
    DBSession.add(newTestFK2)

    transaction.commit()

    return {'project': 'MyProject'}
"""
