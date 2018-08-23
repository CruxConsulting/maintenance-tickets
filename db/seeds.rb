# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create username: 'julien@crx.io', email: 'julien@crx.io', password: 'julien@crx.io'
AdminUser.create username: 'luc.colon@sowilo-network.com', email: 'luc.colon@sowilo-network.com', password: 'luc.colon@sowilo-network.com'