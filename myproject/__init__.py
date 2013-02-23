from pyramid.config import Configurator
from pyramid.events import subscriber
from pyramid.events import NewRequest

from sqlalchemy import engine_from_config

from .models import (
    DBSession,
    Base,
    )

from urlparse import urlparse

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """

    engine = engine_from_config(settings, 'sqlalchemy.')
    DBSession.configure(bind=engine)
    Base.metadata.bind = engine

    config = Configurator(settings=settings)
    config.include('pyramid_jinja2')
    config.add_jinja2_search_path("myproject:templates")
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('menu', '/menu')
    config.add_route('placeOrder', '/placeOrder')
    config.add_route('orders', '/orders')
    config.add_route('pos','/pos')
    config.add_route('admin', '/admin')
    config.add_route('about', '/about')
    config.add_route('test', '/test')
    config.add_route('add_menu_item', '/add_menu_item')
    config.scan()
    return config.make_wsgi_app()
