require_relative './spec_helper'

describe command("crontab -l") do
  test1 = Regexp.escape("0 9 * * 1-5 echo 'test1'")
  test2 = Regexp.escape("0 9 * * 1-5 echo 'test2' >/dev/null 2>&1")
  test3 = Regexp.escape("0 9 * * 1-5 [ `date '+\\%m'` -eq `date -d '-2 week' '+\\%m'` ] && echo 'test3' >/dev/null 2>&1")
  test4 = Regexp.escape("0 9 * * 1-5 [ `date '+\\%m'` -eq `date -d '-3 week' '+\\%m'` ] && echo 'test4' >/dev/null 2>&1")
  test5 = Regexp.escape("0 9 * * 1-5 [ `date '+\\%m'` -ne `date -d '+1 week' '+\\%m'` ] && echo 'test5' >/dev/null 2>&1")
  test6 = Regexp.escape("0 9 * * 1-5 echo 'test6' >/dev/null 2>&1")
  test7 = Regexp.escape("0 9 * * 1-5 echo 'test7' >/dev/null 2>&1")
  its(:stdout) { should match /^#{test1}$/ }
  its(:stdout) { should match /^#{test2}$/ }
  its(:stdout) { should match /^#{test3}$/ }
  its(:stdout) { should match /^#{test4}$/ }
  its(:stdout) { should match /^#{test5}$/ }
  its(:stdout) { should match /^#{test6}$/ }
  its(:stdout) { should match /^#{test7}$/ }
end
