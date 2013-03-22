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
@view_config(route_name='placeOrder', xhr=True, renderer='json')
def placeOrder_view(request):
	print request
	menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()

	return {'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='orders', renderer='templates/orders.jinja2')
@view_config(route_name='orders', xhr=True, renderer='json')
def orders_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='pos', renderer='templates/pos.jinja2')
@view_config(route_name='pos', xhr=True, renderer='json')
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
@view_config(route_name='admin', xhr=True, renderer='json')
def admin_view(request):
    print request
    menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
    menuCategories = DBSession.query(MenuCategory).group_by(MenuCategory.catID).all()

    return {'menuCategories': menuCategories, 'menuItems': menuItems, 'project': 'MyProject'}

@view_config(route_name='about', renderer='templates/about.jinja2')
@view_config(route_name='about', xhr=True, renderer='json')
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

@view_config(renderer='json', route_name='addMenuItem')
@view_config(renderer='json', name='addMenuItem.json')
def addMenuItem_view(request):
	print request

	item = request.json_body

	isVegetarian = item['isVeg']
        if isVegetarian == 'TRUE':
                item['isVeg'] = True
        elif isVegetarian == 'FALSE':
                item['isVeg'] = False;

	newItem = MenuItem(name=item['name'], category=item['category'], price=item['price'], isVeg=item['isVeg'], isActive=True, description=item['description'], image=item['image'])
	existingItem = DBSession.query(MenuItem).filter_by(name=item['name']).first()
	if existingItem:
		return {'isSuccess': 0}
	else:
		DBSession.add(newItem)
		transaction.commit()
		return {'isSuccess': 1}

@view_config(renderer='json', name='orderStatus.json')
def orderStatus_view(request):
	print request
	orderStatus = request.json_body['orderStatus']
	for status in orderStatus:
		order = DBSession.query(Order).filter_by(orderID=status['orderID']).first()
		order.isComplete = status['isComplete']
		transaction.commit()
	return {'isSuccess' : 1}

@view_config(renderer='json', route_name='editMenuItem')
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
		item.description = newItem['description']
		item.image = newItem['image']
        isVegetarian = item['isVeg']
        if isVegetarian == 'TRUE':
            item['isVeg'] = True
        elif isVegetarian == 'FALSE':
            item['isVeg'] = False
            
		transaction.commit()
		return {'isSuccess': 1}
	else:
		return {'isSuccess': 0}

@view_config(renderer='json', name='getMenuName.json')
def getMenuName_view(request):
	print request
	menuItem = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
	jsonString = "["
	for i in range(len(menuItem)):
		if i < (len(menuItem)-1):
			jsonString = jsonString + '{"menuName": "' + menuItem[i].name + '"},'
		else:
			jsonString = jsonString + '{"menuName": "' + menuItem[i].name + '"}'
	jsonString = jsonString + "]"
	print jsonString
	return jsonString

@view_config(renderer='json', name="payForItems.json")
def getPOS_view(request):
	print request

	orderID = request.json_body['order']
	menuItem = request.json_body['menuItem']
	groupNum = request.json_body['group']
	tableNum = request.json_body['table']

	DBSession.query(Order).filter(Order.orderID==orderID, Order.menuItem==menuItem, Order.tableNum==tableNum, Order.groupNum==groupNum).delete()
	transaction.commit()

	return {'isSuccess': 1}

@view_config(renderer='json', name='getOrders.json')
def getOrders_view(request):
	print request
	tableNums = []
	orders = DBSession.query(Order).group_by(Order.orderID).all()
	for i in range(len(orders)):
		if (orders[i].tableNum not in tableNums):
			tableNums.append(orders[i].tableNum)
	
	jsonOrder = '['
	for i in range(len(tableNums)):
		order = DBSession.query(Order).filter_by(tableNum=tableNums[i]).group_by(Order.orderID).all()
		jsonOrder = jsonOrder + '{"tableNum": ' + str(order[0].tableNum) + ', "orders": '
		if len(order) > 1:
			jsonOrder = jsonOrder + '['
		for n in range(len(order)):
			menuItem = DBSession.query(MenuItem).filter_by(menuID=order[n].menuItem).first()
			category = DBSession.query(MenuCategory).filter_by(catID=menuItem.category).first()
			if (len(order) == 0 or n >= (len(order)-1)):
				jsonOrder = jsonOrder + '{"orderID": ' + str(order[n].orderID) + ', "category": "' + category.name + '", "menuName": "' + menuItem.name +'", "groupNum": ' + str(order[n].groupNum) + ', "isComplete": "' + str(order[n].isComplete) + '", "comments": "' + order[n].comments + '"}'
			else:
				jsonOrder = jsonOrder + '{"orderID": ' + str(order[n].orderID) + ', "category": "' + category.name + '", "menuName": "' + menuItem.name + '", "groupNum": ' + str(order[n].groupNum) + ', "isComplete": "' + str(order[n].isComplete) + '", "comments": "' + order[n].comments + '"},'
		if (i < (len(tableNums)-1) and len(order) > 1):
			jsonOrder = jsonOrder + ']},'
		elif (i < (len(tableNums)-1) and len(order) == 1):
			jsonOrder = jsonOrder + '},'
		elif len(order) > 1:
			jsonOrder = jsonOrder + ']}'
		elif len(order) == 1:
			jsonOrder = jsonOrder + '}'
	jsonOrder = jsonOrder + ']'
	print jsonOrder
	return jsonOrder
			
	
@view_config(renderer='json', name='placedOrder.json')
def placedOrder_view(request):
        print request
        orders = request.json_body['Orders']
        for order in orders :
                newOrder = Order(menuItem=order['menuItem'], tableNum=order['tableNum'], groupNum = order['groupNum'], comments=order['comments'])
                DBSession.add(newOrder)
        transaction.commit()
        return {'isSuccess': 1}

@view_config(renderer='json', name='getMenu.json')
def getMenu_view(request):
	print request
	menuItems = DBSession.query(MenuItem).group_by(MenuItem.category, MenuItem.name).all()
	categories = DBSession.query(MenuCategory).group_by(MenuCategory.catID).all()
	jsonMenu = '{"menu": ['
	for i in range(len(menuItems)):
		if i < (len(menuItems)-1):
			category = DBSession.query(MenuCategory).filter_by(catID=menuItems[i].category).first().name
			jsonMenu = jsonMenu + '{"menuID": ' + str(menuItems[i].menuID) + ', "name": "' + menuItems[i].name + '", "category": "' + category + '", "price": ' + str(menuItems[i].price) + ', "isVeg": "' + str(menuItems[i].isVeg) + '", "isActive": "' + str(menuItems[i].isActive) + '", "description": "' + menuItems[i].description + '"},'
		else:
			jsonMenu = jsonMenu + '{"menuID": ' + str(menuItems[i].menuID) + ', "name": "' + menuItems[i].name + '", "category": "' + category + '", "price": ' + str(menuItems[i].price) + ', "isVeg": "' + str(menuItems[i].isVeg) + '", "isActive": "' + str(menuItems[i].isActive) + '", "description": "' + menuItems[i].description + '"}'
	jsonMenu = jsonMenu + '], "categories": ['
	for i in range(len(categories)):
		if i < (len(categories)-1):
			jsonMenu = jsonMenu + '{"catID": ' + str(categories[i].catID) + ', "name": "' + categories[i].name + '"},'
		else:
			jsonMenu = jsonMenu + '{"catID": ' + str(categories[i].catID) + ', "name": "' + categories[i].name + '"}'
	jsonMenu = jsonMenu + ']}'
	print jsonMenu
	return jsonMenu

