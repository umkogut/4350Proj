from pyramid.view import view_config
from jinja2 import Environment, FileSystemLoader

from .models import (
    DBSession,
    MenuItem,
    )

@view_config(route_name='home', renderer='templates/index.jinja2')
def my_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='menu', renderer='templates/menu.jinja2')
def cook_view(request):
    print request

    print "Loading the menu"
    item = DBSession.query(MenuItem).first()
    if item is None:
	print "There is nothing in the menu"

    return {'item': item, 'project': 'MyProject'}

@view_config(route_name='orders', renderer='templates/orders.jinja2')
def orders_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='admin', renderer='templates/admin.jinja2')
def admin_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='about', renderer='templates/about.jinja2')
def about_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='test', renderer='templates/test.jinja2')
def test_view(request):
    print request
    return {'project': 'MyProject'}
