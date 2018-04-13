# cron_wom Cookbook CHANGELOG

## 1.0.1 (2018-04-13)

- Eliminate the dependency on `compat_resource`, which means the minimum
  supported Chef version is now 12.5
- Switch to InSpec
- Remove CentOS 5 from testing
- Fix one line where we weren't using the `new_resource.<attribute>` syntax

## 1.0.0 (2016-07-25)

- Initial release
