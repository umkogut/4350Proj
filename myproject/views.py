import pdb
import transaction;

from pyramid.renderers import render
from pyramid.response import Response
from pyramid.view import view_config
from jinja2 import Environment, FileSystemLoader

from .models import (
    DBSession,
    MenuItem,
    MenuCategory,
    Order,
    )

@view_config(route_name='home', renderer='templates/index.jinja2')
def my_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='menu', renderer='templates/menu.jinja2')
@view_config(route_name='menu', xhr=True, renderer='json')
def cook_view(request):
	print request

	print "Loading the menu"
	menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
	menuCategories = DBSession.query(MenuCategory).group_by(MenuCategory.catID).all()
	print menuItems

	if menuItems is None:
		print "There is nothing in the menu"

	return {'menuCategories': menuCategories, 'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='placeOrder', renderer='templates/placeOrder.jinja2')
def placeOrder_view(request):
	print request
	menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()

	return {'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='orders', renderer='templates/orders.jinja2')
def orders_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='pos', renderer='templates/pos.jinja2')
def pos_view(request):
    print request
    orders = DBSession.query(Order).group_by(Order.orderID).all()
    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()


    tableNums = list()
    if orders != None:
	for order in orders:
	    if order.tableNum not in tableNums:
		tableNums.append(order.tableNum)

    return {'menuItems': menuItems, 'tableNums': tableNums, 'orders': orders, 'project': 'MyProject'}

@view_config(route_name='admin', renderer='templates/admin.jinja2')
def admin_view(request):
    print request
    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
    menuCategories = DBSession.query(MenuCategory).group_by(MenuCategory.catID).all()

    return {'menuCategories': menuCategories, 'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='about', renderer='templates/about.jinja2')
def about_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='test', renderer='templates/test.jinja2')
def test_view(request):
    print request

    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
    menuCategories = DBSession.query(MenuCategory).group_by(MenuCategory.catID).all()

    return {'menuCategories': menuCategories, 'menuItems': menuItems, 'project': 'MyProject'}

@view_config(renderer='json', name='getMenuItem.json')
def getMenuItem_view(request):
	print request
	itemName = request.json_body['name']
	item = DBSession.query(MenuItem).filter_by(name=itemName).first()

	if item:
		return {'menuID': item.menuID, 'name': item.name, 'category': item.category, 'price': item.price, 'isVeg': item.isVeg, 'isActive': item.isActive, 'description': item.description, 'image': item.image}
	else:
		return {'isSuccess': 0}

@view_config(renderer='json', name='addMenuItem.json')
def addMenuItem_view(request):
	print request

	item = request.json_body
	newItem = MenuItem(name=item['name'], category=item['category'], price=item['price'], isVeg=item['isVeg'], isActive=True, description=item['description'], image=item['image'])
	existingItem = DBSession.query(MenuItem).filter_by(name=item['name']).first()
	if existingItem:
		return {'isSuccess': 0}
	else:
		DBSession.add(newItem)
		transaction.commit()
		return {'isSuccess': 1}

@view_config(renderer='json', name='editMenuItem.json')
def editMenuItem_view(request):
	print request
	newItem = request.json_body
	prevItemName = request.json_body['prevItemName']
	item = DBSession.query(MenuItem).filter_by(name=newItem['prevItemName']).first()
	if item:
		item.name = newItem['name']
		item.category = newItem['category']
		item.price = newItem['price']
		item.isVeg = newItem['isVeg']
		item.description = newItem['description']
		item.image = newItem['image']
		transaction.commit()
		return {'isSuccess': 1}
	else:
		return {'isSuccess': 0}

@view_config(renderer='json', name='getMenuName.json')
def getMenuName_view(request):
	print request
	menuItem = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
	jsonString = "{"
	for i in range(len(menuItem)):
		if i < (len(menuItem)-1):
			jsonString = jsonString + "\"" + str(menuItem[i].menuID) + "\": \"" + menuItem[i].name + "\","
		else:
			jsonString = jsonString + "\"" + str(menuItem[i].menuID) + "\": \"" + menuItem[i].name + "\""
	jsonString = jsonString + "}"
	print jsonString
	return jsonString
	
@view_config(renderer='json', name='placedOrder.json')
def placedOrder_view(request):
        print request
        orders = request.json_body['Orders']
        for order in orders :
                newOrder = Order(menuItem=order['menuItem'], tableNum=order['tableNum'], groupNum = order['groupNum'], comments=order['comments'])
                DBSession.add(newOrder)
        transaction.commit()
        return {'isSuccess': 1}
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
