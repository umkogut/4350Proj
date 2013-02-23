from sqlalchemy import (
    Column,
    Integer,
    Numeric,
    String,
    BOOLEAN,
    ForeignKey
    )

from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    )

from zope.sqlalchemy import ZopeTransactionExtension

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base()

class MenuItem(Base):
    __tablename__ = 'menuItems'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False)
    category = Column(String(50), nullable=False)
    price = Column(Numeric, nullable=False)
    isVegetarian = Column(BOOLEAN, nullable=False)
    isActive = Column(BOOLEAN, nullable=False)

    def __init__(self, name, category, price, isVegetarian, isActive):
        self.name = name
	self.category = category
	self.price = price
	self.isVegetarian = isVegetarian
	self.isActive = isActive
