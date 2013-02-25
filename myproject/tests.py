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

# View Tests

class ViewMenuTests(unittest.TestCase):
    def _callFUT(self, request):
	from .views import cook_view
	return cook_view(request)

    #def test_view(self):
	menuItems = testing.DummyResource()
	menuCategories = testing.DummyResource()
	request = testing.DummyRequest()
	#view_info = self._callFUT(request)

	#self.assertEqual(view_info['project'], 'MyProject')
	#self.assertEqual(view_info['menuCategories'], menuCategories)
	#self.assertEqual(view_info['menuItems'], menuItems)	

class ViewPlaceOrderTests(unittest.TestCase):
    def _callFUT(self, request):
	from .views import placeOrder_view
	return placeOrder_view(request)

    def test_view(self):
	request = testing.DummyRequest()
	menuItems = testing.DummyResource()
	#view_info = self._callFUT(request)
	#self.assertEqual(view_info['project'], 'MyProject')

class ViewOrdersTest:
    def _callFUT(self, request):
	from .views import orders_view
	return orders_view(request)

    def test_view(self):
	request = testing.DummyRequest()
	view_info = self._callFUT(request)
	self.assertEqual(view_info['project'], 'MyProject')

class ViewPOSTest:
    def _callFUT(self, request):
        from .views import pos_view
        return pos_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewAdminTest:
    def _callFUT(self, request):
        from .views import admin_view
        return admin_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewAboutTest:
    def _callFUT(self, request):
        from .views import about_view
        return about_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewTest:
    def _callFUT(self, request):
        from .views import test_view
        return test_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')

class ViewUpdatesTest:
    def _callFUT(self, request):
        from .views import updates_view
        return updates_view(request)

    def test_view(self):
        request = testing.DummyRequest()
        view_info = self._callFUT(request)
        self.assertEqual(view_info['project'], 'MyProject')


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
