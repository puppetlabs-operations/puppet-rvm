class rvm::packages::debian {
  $packages = [
    'build-essential',
    'curl',
    'gnupg',
    'gawk',
    'sed',
    'grep',
    'gzip',
    'bzip2',
    'zlib1g-dev',
    'libssl-dev',
  ]

  # Detect Debian version and set the appropriate readline package
  if $facts['os']['release']['major'] >= '11' {
    $readline_package = 'libreadline-dev'  # Use correct package for Debian 11+
  } else {
    $readline_package = 'libreadline-gplv2-dev'  # Older versions
  }

  ensure_packages($packages + [$readline_package], {'ensure' => 'installed'})
}