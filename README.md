init

what are floating ip ?

cluster of 2 pfsense

securite ovh 2fa

cree un projet public cloud
instances > cree un instance > choix de l'instance b27
choix de l'image rocky linux 9
add ssh
configurer votre reseau -> mode prive avec gateway

cree un reseau prive avec gateway


vlan int
172.16.0.0/25
172.16.0.60

what is openstack nova

block storage attache a l'instance 50go

## ovh 17 juin

2 versions, standard et beta de l'interface

interface horizon -> horizon.cloud.ovh.net/project (interface openstack)

### instances

2 instances pour l'instant

1 instance pfsense avec iso de pfsense 2.7.2
- creation du volume avant l'instance sinon pfsense ne voulait pas booter
- racrochage du volume avec l'instance en utilisant horizon sinon ca ne fonctionnait pas

2 reseaux

creation d'une ip publique
- puis rattache au pfsense


### creation instances

- gra9 gravelines -> localisation
- selection de l'image
- ajout d'une ssh key

pfsense needed before so we can access the machine through ssh
or use public ip and set it to instance

rocky user is default for rocky linux
the rocky user need to be created otherwise we won't have access to the VNC console through ovh

flexible instance sur ovh?

choisir le reseau prive attention a cree le reseau prive avant
sur le reseau il faut un gateway sinon l'instances n'aura pas d'ip assigne

donc cree le gateway puit le private network


pas recommender de mettre une ip publique sur le pfsense donc creation d'un reseau intermediaire WAN 10.0.0.0/24 a qui une ip publique est assigne
available 10.0.0.2 - 10.0.0.254

notion de port pour injecter une ip dans l'instance. Openstack horizon > networks > LAN > ports

172.16.0.1 pfsense
172.16.0.100 vm
172.16.0.25 base de donnee

172.16.0.3
172.16.0.2
are ip generated automatically needed for something

### databases
base de donnees as a service, long a demarrer 1 a 6 minutes

bouton creer un services 
pas de souci sur la creation de base de donnees 

ip non choisis 172.16.0.25
certificat donne dans les informations de connection qu'il faut utiliser pour se connecter

psql host=<host> port=<port> dbname=<dbname> user=<usr ex: asc> sslmode=require sslrootcert=<path to ssl cert>

### creation d'un block storage ~= volume

creation du block storage puis essayer de l'attacher a l'instance
-> message aucune instance disponible dans la region du volume
-> resolution aller dans horizon > volumes > manager attachement > attach to instance >

l'assignement du block storage a l'instance ne fonctionne pas sur l'interface d'ovh mais fonctionne avec horizon


si on veut que les packet du wan se rende sur internet il faut changer dans horizon > networks> LAN > edit port and port security. activer de base il faut le desactiver.
ca sert de base a faire de l'anti spoofing
si activer il faut des security groups mais de base il faut les acheter? sinon message quota exceeded

bare metal > network > network security dashboard

security groups?
egress ? ingress ?
