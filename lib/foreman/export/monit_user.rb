require "erb"
require "foreman/export"

class Foreman::Export::MonitUser < Foreman::Export::Base
  def export
    super

    options[:template] = File.expand_path("../../../../data/export/monit_user", __FILE__)

    clean File.join(location,'.monitrc')

    pid_dir = File.join(location, app, 'shared', 'pids')

    write_template 'monit_user/monitrc.erb', '.monitrc', binding
  end

  def location
    "/home/#{user}/"
  end

  def user
    options[:user] || `whoami`.strip
  end
end
