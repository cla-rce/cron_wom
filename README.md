# cron_wom Cookbook

Provides a `cron_wom` resource that allows you to schedule cron jobs for a
specific instance of a weekday within a month - for example, the first Monday.
It also provides a workaround for not being able to set an empty `MAILTO`
variable for cron jobs (see chef/chef#4900).

## Requirements

### Platforms

Should work on any Linux platform that Chef supports, but has only been tested
on CentOS and Ubuntu.

### Chef
- Chef 12.0+ (so we can use the newer resource syntax)

### Cookbooks
- [compat_resource](https://supermarket.chef.io/cookbooks/compat_resource)
  (enables the Chef 12.5+ resource syntax for Chef 12.0-12.4 clients)

## Usage

Add `depends 'cron_wom'` to your recipe's `metadata.rb`. After that, use the
`cron_wom` resource like you would use Chef's `cron` resource, except now you
can add a `week_of_month` property:

```
cron_wom "this is only a test" do
  command "echo 'test'"
  week_of_month "third"
  hour "9"
  minute "0"
  weekday "1-5"
  mailto ""
end
```

Except for `week_of_month` and `mailto`, properties are fed directly to a Chef
`cron` resource (see <https://docs.chef.io/resource_cron.html>).

Valid inputs for the `week_of_month` property are:

- `first`, `1st`, or anything that begins with `1` (such as `12345`)
- `second`, `2nd`, or anything that begins with `2`
- `third`, `3rd`, or anything that begins with `3`
- `fourth`, `4th`, or anything that begins with `4`
- `last`
- `""` (empty string), `nil`, or `*`

**NOTE 1:** It is possible to set conflicting options that will result in a task
never executing (e.g. `week_of_month` = first and `day` = 8).

**NOTE 2:** Many cron implementations will execute a task if either `day`
matches **OR** `weekday` matches. Keep this in mind when picking a time, and
make use of `week_of_month` when necessary.

## To-Do / Limitations

- Testing of cron job removal needs to be implemented.
- Come up with a better cookbook / resource name.

## License & Authors

**Author:** Peter Walz, University of Minnesota ([pnw@umn.edu](mailto:pnw@umn.edu))

**Copyright:** 2016, Peter Walz and the Regents of the University of Minnesota

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
