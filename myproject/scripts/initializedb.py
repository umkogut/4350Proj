import os
import sys
import transaction

from sqlalchemy import engine_from_config

from pyramid.paster import (
    get_appsettings,
    setup_logging,
    )

from ..models import (
    DBSession,
    MenuCategory,
    MenuItem,
    PayMethod,
    UserType,
    User,
    Base,
    )


def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <config_uri>\n'
          '(example: "%s development.ini")' % (cmd, cmd))
    sys.exit(1)


def main(argv=sys.argv):
    if len(argv) != 2:
        usage(argv)
    config_uri = argv[1]
    setup_logging(config_uri)
    settings = get_appsettings(config_uri)
    engine = engine_from_config(settings, 'sqlalchemy.')
    DBSession.configure(bind=engine)
    Base.metadata.create_all(engine)
    with transaction.manager:
	appetizers = MenuCategory(name='Appetizers')
	DBSession.add(appetizers)

	entrees = MenuCategory(name='Entrees')
	DBSession.add(entrees)

	dessert = MenuCategory(name='Dessert')
	DBSession.add(dessert)

	ceasarSalad = MenuItem(name='Ceasar Salad', category=1, price=1.95, isVeg=False, isActive=True, description='Salad', image="")
	DBSession.add(ceasarSalad)

        cheeseburger = MenuItem(name='Cheese Burger', category=2, price=5.00, isVeg=False, isActive=True, description='Burger', image="")
        DBSession.add(cheeseburger)

	veggieburger = MenuItem(name='Veggie Burger', category=2, price=3.00, isVeg=True, isActive=True, description='Burger', image="")
	DBSession.add(veggieburger)

	chocolateCake = MenuItem(name='ChocolateCake', category=3, price=1.45, isVeg=False, isActive=True, description='Cake', image="")
	DBSession.add(chocolateCake)
