require_relative './spec_helper'

describe command("crontab -l") do
  jobs = []
  jobs << "0 9 * * 1-5 echo 'test1'"
  jobs << "0 9 * * 1-5 echo 'test2' >/dev/null 2>&1"
  jobs << "0 9 * * 1-5 [ `date '+\\%m'` -eq `date -d '-2 week' '+\\%m'` ] && echo 'test3' >/dev/null 2>&1"
  jobs << "0 9 * * 1-5 [ `date '+\\%m'` -eq `date -d '-3 week' '+\\%m'` ] && echo 'test4' >/dev/null 2>&1"
  jobs << "0 9 * * 1-5 [ `date '+\\%m'` -ne `date -d '+1 week' '+\\%m'` ] && echo 'test5' >/dev/null 2>&1"
  jobs << "0 9 * * 1-5 echo 'test6' >/dev/null 2>&1"
  jobs << "0 9 * * 1-5 echo 'test7' >/dev/null 2>&1"

  jobs.each do |job|
    its(:stdout) { should match /^#{Regexp.escape(job)}$/ }
  end
end
