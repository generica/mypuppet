# templates.pp
# All server templates for various flavors of templates defined here

class baseclass {
  include os-base
}

class web-server {
  include apache
}
