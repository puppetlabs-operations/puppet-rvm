# @summary
#   Installs a rubygems version for the specified ruby version.
#
#   Although RVM does support installing non-semantic versions, such as 'latest',
#   'latest-x.y', 'head', 'master', or 'remove' (To reset to orignal version),
#   this module does not yet support enforcing those.
#
# @example Ensure a specific rubygems version
#   rvm::define::rubygems { 'ruby-3.1.3-rubygems-3.3.26':
#     rubygems_version => '3.3.26',
#     ruby_version     => '3.1.3',
#   }
#
# @example Ensure a specific rubygems version for a named gemset
#   rvm::define::rubygems { 'ruby-3.1.3-testing-rubygems-3.3.26':
#     rubygems_version => '3.3.26',
#     ruby_version     => '3.1.3',
#     gemset           => 'testing'
#   }
#
# @param ruby_version
#   The rubygems version to install under the specified ruby_version.
#
# @param rubygems_version
#   The rubygems version to install under the specified ruby_version.
#    Valid values are a semantic version.
#
# @param gemset
#   The rubygems version to install under the specified ruby_version and named gemset.
#
#
define rvm::define::rubygems (
  String[1] $ruby_version,
  String[1] $rubygems_version,
  Optional[String[1]] $gemset = undef,
) {
  if $gemset == undef {
    $rvm_depency = "install-ruby-${ruby_version}"
    $rubyset_version = $ruby_version
  } else {
    $rvm_depency = "rvm-gemset-create-${gemset}-${ruby_version}"
    $rubyset_version = "${ruby_version}@${gemset}"
  }

  exec { "${ruby_version}-rvm-rubygems-${rubygems_version}":
    command   => "rvm ${rubyset_version} do rvm rubygems ${rubygems_version} --force",
    path      => '/usr/local/rvm/bin:/bin:/sbin:/usr/bin:/usr/sbin',
    onlyif    => "sh -c '[[ $(rvm ${rubyset_version} do gem --version) != \"${rubygems_version}\" ]] || exit 1'",
    logoutput => true,
    require   => [Class['rvm'], Exec[$rvm_depency]],
  }
}
