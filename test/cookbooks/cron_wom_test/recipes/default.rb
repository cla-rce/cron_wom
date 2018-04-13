#
# Cookbook Name:: cron_wom_test
# Recipe:: default
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

cron_wom "test1" do
  command "echo 'test1'"
  hour "9"
  minute "0"
  weekday "1-5"
end

cron_wom "test2" do
  command "echo 'test2'"
  week_of_month ""
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end

cron_wom "test3" do
  command "echo 'test3'"
  week_of_month "3"
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end

cron_wom "test4" do
  command "echo 'test4'"
  week_of_month "4th"
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end

cron_wom "test5" do
  command "echo 'test5'"
  week_of_month "last"
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end

cron_wom "test6" do
  command "echo 'test6'"
  week_of_month "*"
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end

# Should generate a warning in the log...
cron_wom "test7" do
  command "echo 'test7'"
  week_of_month "bogus"
  hour "9"
  minute "0"
  mailto ""
  weekday "1-5"
end
