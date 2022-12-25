#!/bin/sh

##
##
## Copyright 2022 Fred Dushin <fred@dushin.net>
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##    http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
## SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
##

echo "Enabling rabbitmq..."
sysrc -f /etc/rc.conf rabbitmq_enable="YES"

echo -n "Starting RabbitMQ..."
service rabbitmq start
sleep 10

## sync the cookies so we can use CLI tools
cp /var/db/rabbitmq/.erlang.cookie /root/.erlang.cookie
rabbitmqctl await_startup

## print status (remove in a release)
rabbitmqctl -q ping
rabbitmqctl status

## create the admin user with open permissions and administrator role
ADMIN_PW=$(openssl rand -base64 18)
rabbitmqctl add_user admin $ADMIN_PW
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

## Enable the management UI
rabbitmq-plugins enable rabbitmq_management

# Save data
touch /root/PLUGIN_INFO
echo "rabbitmq user: admin" >> /root/PLUGIN_INFO
echo "rabbitmq password: $ADMIN_PW" >> /root/PLUGIN_INFO
