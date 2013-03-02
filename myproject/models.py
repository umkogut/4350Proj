from sqlalchemy import (
    Column,
    Integer,
    Numeric,
    String,
    BOOLEAN,
    ForeignKey,
	REAL
    )

from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    )

from zope.sqlalchemy import ZopeTransactionExtension

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base()

class MenuCategory(Base):
	__tablename__ = 'MENU_CATEGORIES'
	catID = Column(Integer, primary_key=True)
	name = Column(String, nullable=False)

	def __init__(self, name):
		self.name = name

class MenuItem(Base):
	__tablename__ = 'MENU'
	menuID = Column(Integer, primary_key=True)
	name = Column(String, nullable=False)
	category = Column(Integer, ForeignKey("MENU_CATEGORIES.catID"), nullable=False)
	price = Column(REAL, nullable=False)
	isVeg = Column(BOOLEAN, nullable=False)
	isActive = Column(BOOLEAN, nullable=False)
	description = Column(String, nullable=True)
	image = Column(String, nullable=True)

	def __init__(self, name, category, price, isVeg, isActive, description, image):
		self.name = name
		self.category = category
		self.price = price
		self.isVeg = isVeg
		self.isActive = isActive
		self.description = description
		self.image = image

class Order(Base):
	__tablename__ = 'ORDERS'
	orderID = Column(Integer, primary_key=True)
	menuItem = Column(Integer, ForeignKey("MENU.menuID"), nullable=False)
	tableNum = Column(Integer, nullable=False)
	groupNum = Column(Integer, nullable=False)
	isComplete = Column(BOOLEAN, nullable=False)
	comments = Column(String, nullable=True)

	def __init__(self, menuItem, tableNum, groupNum, comments):
		self.menuItem = menuItem
		self.tableNum = tableNum
		self.groupNum = groupNum
		self.isComplete = False
		self.comments = comments

class PayMethod(Base):
	__tablename__ = 'PAY_METHODS'
	methodID = Column(Integer, primary_key=True)
	name = Column(String, nullable=False)

	def __init__(self, name):
		self.name = name

class UserType(Base):
	__tablename__ = 'USER_TYPES'
	typeID = Column(Integer, primary_key=True)
	name = Column(String, nullable=False)

	def __init__(self, name):
		self.name = name

class User(Base):
	__tablename__ = 'USERS'
	userID = Column(Integer, primary_key=True)
	userName = Column(String, nullable=False)
	userType = Column(Integer, ForeignKey("USER_TYPES.typeID"), nullable=False)
	password = Column(String, nullable=False)

	def __init__(self, userName, userType, password):
		self.userName = userName
		self.userType = userType
		self.password = password

class Transaction(Base):
	__tablename__ = 'TRANSACTIONS'
	transactionID = Column(Integer, primary_key=True)
	amount = Column(REAL, nullable=False)
	paymentMethod = Column(Integer, ForeignKey("PAY_METHODS.methodID"), nullable=False)
	whenProcessed = Column(Numeric, nullable=False)
	userID = Column(Integer, ForeignKey("USERS.userID"), nullable=False)

	def __init__(self, amount, paymentMethod, whenProcessed, userID):
		self.amount = amount
		self.paymentMethod = paymentMethod
		self.whenProcessed = whenProcessed
		self.userID = userID

