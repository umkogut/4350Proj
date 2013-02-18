from pyramid.view import view_config
from jinja2 import Environment, FileSystemLoader

@view_config(route_name='home', renderer='templates/index.jinja2')
def my_view(request):
    print request
    return {'project': 'MyProject'}

@view_config(route_name='menu', renderer='templates/menu.jinja2')
def cook_view(request):
    print request
    return {'project': 'MyProject'}

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
