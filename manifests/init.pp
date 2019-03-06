# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mono
class mono (
  String $package_name = 'mono-complete',
  String $gpg_id = '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF',
  String $gpg_server = 'hkp://keyserver.ubuntu.com:80'
) {
  package { 'gnupg': }
  package { 'ca-certificates': }

  apt::key { 'mono':
    id     => $gpg_id,
    server => $gpg_server,
  }

  apt::source { 'mono':
    comment  => 'Mono Stable Repository',
    location => 'https://download.mono-project.com/repo/ubuntu',
    release  => 'stable-bionic',
    repos    => 'main',
    require  => [
      Package[gnupg],
      Package[ca-certificates],
    ],
  }

  package { 'mono-complete':
    require => [
      Apt::Key[mono],
      Apt::Source[mono],
    ],
  }
}
