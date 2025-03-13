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
    'libreadline-dev',
  ]

  ensure_packages($packages, {'ensure' => 'installed'})
}