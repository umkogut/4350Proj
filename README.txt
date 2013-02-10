Group 6 4350 Project README



/************************************************************************/
To launch server:

From root

cd python/pyramid/install/env/4350Proj

python setup.py develop

python setup.py test -q

pserve development.ini


From EC2 instances, take the URL (ie. http://ec2-67-202-40-206.compute-1.amazonaws.com) and add the port ':6543'
Put in web browser and you should now see the server.
/************************************************************************/
