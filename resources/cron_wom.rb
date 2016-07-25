#
# Cookbook Name:: cron_wom
# Resource:: cron_wom
#
# Copyright 2016, Peter Walz, (C) Regents of the University of Minnesota
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

resource_name :cron_wom

property :task_name, String, name_property: true
property :command, String, required: true
property :day, String
property :environment, Hash
property :home, String
property :hour, String
property :mailto, String
property :minute, String
property :month, String
property :path, String
property :shell, String
property :time, Symbol
property :user, String
property :weekday, [String, Symbol]
property :week_of_month, String

default_action :create

def get_week_test
  case week_of_month
  when /^(1|first)/i
    "[ `date '+\\%m'` -ne `date -d '-1 week' '+\\%m'` ] && "
  when /^(2|second)/i
    "[ `date '+\\%m'` -eq `date -d '-1 week' '+\\%m'` ] && "
  when /^(3|third)/i
    "[ `date '+\\%m'` -eq `date -d '-2 week' '+\\%m'` ] && "
  when /^(4|fourth)/i
    "[ `date '+\\%m'` -eq `date -d '-3 week' '+\\%m'` ] && "
  when /^last/i
    "[ `date '+\\%m'` -ne `date -d '+1 week' '+\\%m'` ] && "
  when /^\*/
    ""
  when /^./
    Chef::Log.warn("cron_wom resource: unknown week_of_month provided ('#{week_of_month}'), defaulting to any")
    ""
  else
    ""
  end
end

def check_mailto
  # Work around Chef #4900 ( https://github.com/chef/chef/issues/4900 )
  if property_is_set?(:mailto) && (mailto.length == 0)
    reset_property(:mailto)
    return " >/dev/null 2>&1"
  else
    return ""
  end
end

action :create do
  nomail = check_mailto
  cron task_name do
    command "#{get_week_test}#{new_resource.command}#{nomail}"
    day new_resource.day
    environment new_resource.environment
    home new_resource.home
    hour new_resource.hour
    mailto new_resource.mailto
    minute new_resource.minute
    month new_resource.month
    path new_resource.path
    shell new_resource.shell
    time new_resource.time
    user new_resource.user
    weekday new_resource.weekday
    action :create
  end
end

action :delete do
  nomail = check_mailto
  cron new_resource.task_name do
    command "#{get_week_test}#{new_resource.command}#{nomail}"
    day new_resource.day
    environment new_resource.environment
    home new_resource.home
    hour new_resource.hour
    mailto new_resource.mailto
    minute new_resource.minute
    month new_resource.month
    path new_resource.path
    shell new_resource.shell
    time new_resource.time
    user new_resource.user
    weekday new_resource.weekday
    action :delete
  end
end
