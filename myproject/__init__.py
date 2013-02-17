from pyramid.config import Configurator
from pyramid.events import subscriber
from pyramid.events import NewRequest

from urlparse import urlparse
import pymongo

from pymongo import MongoClient

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.include('pyramid_jinja2')
    config.add_jinja2_search_path("myproject:templates")
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('menu', '/menu')
    config.add_route('orders', '/orders')
    config.add_route('admin', '/admin')
    config.add_route('about', '/about')
    config.scan()
    return config.make_wsgi_app()
