class rvm::packages::debian {
  $packages = ['build-essential', 'curl', 'gnupg', 'bash', 'gawk', 'sed',
    'grep', 'gzip', 'bzip2', 'zlib1g-dev', 'libssl-dev',
    'libreadline-gplv2-dev']
  $packages.each |$package| {
    if ! defined(Package[$package]) {
      package { $package:
        ensure => installed,
      }
    }
  }
}
