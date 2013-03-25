import unittest

from pyramid import testing

# Model tests
class MenuCategoryModelTests(unittest.TestCase):
    def _getTargetClass(self):
	from .models import MenuCategory
	return MenuCategory

    def _makeOne(self):
	return self._getTargetClass()(u'testname')

    def test_constructor(self):
	instance = self._makeOne()
	self.assertEqual(instance.name, u'testname')

class MenuItemModelTests(unittest.TestCase):
    def _getTargetClass(self):
	from .models import MenuItem
	return MenuItem

    def _makeOne(self):
	return self._getTargetClass()(u'testname', 'testcategory', 0, False, False, 'testdescription', None)

    def test_constructor(self):
	instance = self._makeOne()
	self.assertEqual(instance.name, u'testname')
	self.assertEqual(instance.category, 'testcategory')
	self.assertEqual(instance.price, 0)
	self.assertEqual(instance.isVeg, False)
	self.assertEqual(instance.isActive, False)
	self.assertEqual(instance.description, 'testdescription')
	self.assertEqual(instance.image, None)

class PayMethodModelTests(unittest.TestCase):
    def _getTargetClass(self):
        from .models import PayMethod
        return PayMethod

    def _makeOne(self):
        return self._getTargetClass()(u'testname')

    def test_constructor(self):
        instance = self._makeOne()
        self.assertEqual(instance.name, u'testname')


class UserTypeModelTests(unittest.TestCase):
    def _getTargetClass(self):
        from .models import UserType
        return UserType

    def _makeOne(self):
        return self._getTargetClass()(u'testname')

    def test_constructor(self):
        instance = self._makeOne()
        self.assertEqual(instance.name, u'testname')

class UserModelTests(unittest.TestCase):
    def _getTargetClass(self):
        from .models import User
        return User

    def _makeOne(self):
        return self._getTargetClass()(u'testname', 'testtype', 'testpw')

    def test_constructor(self):
        instance = self._makeOne()
        self.assertEqual(instance.userName, u'testname')
	self.assertEqual(instance.userType, 'testtype')
	self.assertEqual(instance.password, 'testpw')

class OrderModelTests(unittest.TestCase):
    def _getTargetClass(self):
	from .models import Order
	return Order

    def _makeOne(self):
	return self._getTargetClass()(1, 1, 1, 'testcomments')

    def test_constructor(self):
	instance = self._makeOne()
	self.assertEqual(instance.menuItem, 1)
	self.assertEqual(instance.tableNum, 1)
	self.assertEqual(instance.groupNum, 1)
	self.assertEqual(instance.isComplete, False)
	self.assertEqual(instance.comments, 'testcomments')

class TransactionModelTests(unittest.TestCase):
    def _getTargetClass(self):
	from .models import Transaction
	return Transaction

    def _makeOne(self):
	return self._getTargetClass()

    def test_constructor(self):
	instance = self._makeOne()

# View Tests

class ViewMenuTests(unittest.TestCase):
    def _callFUT(self, request):
	from .views import cook_view
	return cook_view(request)

    def test_menu_view(self):
	menuItems = testing.DummyResource()
	menuCategories = testing.DummyResource()
	request = testing.DummyRequest()
	view_info = self._callFUT(request)
	self.assertEqual(view_info['project'], 'MyProject')
	self.assertEqual(view_info['menuCategories'], menuCategories)
	self.assertEqual(view_info['menuItems'], menuItems)	

class ViewPlaceOrderTests(unittest.TestCase):
    def _callFUT(self, request):
	from .views import placeOrder_view
	return placeOrder_view(request)

    def test_place_orders_view(self):
	request = testing.DummyRequest()
	menuItems = testing.DummyResource()
	view_info = self._callFUT(request)
	self.assertEqual(view_info['project'], 'MyProject')
	self.assertEqual(view_info['menuItems'], menuItems)

class ViewOrdersTest(unittest.TestCase):
    def _callFUT(self, request):
	from .views import orders_view
	return orders_view(request)

    def test_orders_view(self):
	request = testing.DummyRequest()
	view_info = self._callFUT(request)
	self.assertEqual(view_info['project'], 'MyProject')

class ViewPOSTest(unittest.TestCase):
    def _callFUT(self, request):
        from .views import pos_view
        return pos_view(request)

    def test_pos_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewAdminTest(unittest.TestCase):
    def _callFUT(self, request):
        from .views import admin_view
        return admin_view(request)

    def test_admin_view(self):
        request = testing.DummyRequest()
	menuItems = testing.DummyResource()
	menuCategories = testing.DummyResource()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')
	self.assertEqual(view_info['menuItems'], menuItems)
	self.assertEqual(view_info['menuCategories'], menuCategories)

class ViewAboutTest(unittest.TestCase):
    def _callFUT(self, request):
        from .views import about_view
        return about_view(request)

    def test_about_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewTest(unittest.TestCase):
    def _callFUT(self, request):
        from .views import test_view
        return test_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class GetMenuItemViewTest(unittest.TestCase):
    def _callFUT(self, request):
	from .views import getMenuItem_view
	return getMenuItem_view(request)

    def test_getMenuItem_view(self):
	request = testing.DummyRequest()
	view_info = self._callFUT(request)
	item = testing.DummyResource()
	self.assertEqual(view_info['menuID'], item.menuID)
 	self.assertEqual(view_info['name'], item.name) 
 	self.assertEqual(view_info['category'], item.category) 
 	self.assertEqual(view_info['price'], item.price) 
	self.assertEqual(view_info['isVeg'], item.isVeg]) 
	self.assertEqual(view_info['isActive'], item.isActive) 
	self.assertEqual(view_info['description'], item.description) 
	self.assertEqual(view_info['image'], item.image) 

class AddMenuItemViewTest(unittest.TestCase):
    def _callFUT(self, request):
	from .views import addMenuItem_view
	return addMenuItem_view(request)

    def test_addMenuItem_view(self):
	request = testing.DummyRequest()
	view_info = self._callFUT(request)
 	item = request.DummyResource()
	self.assertEqual(view_info['isSuccess'], 1)

class OrderStatusViewTest(unittest.TestCase):                                                                                                                                      
    def _callFUT(self, request):
        from .views import orderStatus_view                                                                                                                                        
        return orderStatus_view(request)                                                                                                                                           

    def test_orderStatus_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        orderStatus = request.DummyResource()
	self.assertEqual(orderStatus.isComplete, 'isComplete')
        self.assertEqual(view_info['isSuccess'], 1)

class EditMenuItemViewTest(unittest.TestCase):                                                                                                                                
    def _callFUT(self, request):
        from .views import editMenuItem_view                                                                                                               
        return editMenuItem_view(request)                                                                                                                                     

    def test_editMenuItem_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        item = request.DummyResource()
	newItem = request.DummyResource()
        self.assertEqual(view_info['isSuccess'], 1)

class ViewIndexTests(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_my_view(self):
        from .views import my_view
        request = testing.DummyRequest()
        info = my_view(request)
        self.assertEqual(info['project'], 'MyProject')
