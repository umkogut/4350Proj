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
    MenuItem,
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
        cheeseburger = MenuItem(name='Cheese Burger', category='Entrees', price=5.00, isVegetarian=False, isActive=True)
        DBSession.add(cheeseburger)

	veggieburger = MenuItem(name='Veggie Burger', category='Entrees', price=3.00, isVegetarian=True, isActive=True)
	DBSession.add(veggieburger)
