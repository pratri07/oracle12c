
package 'binutils'

package 'compat-libcap1'

package 'compat-libstdc++-33'

yum_package 'compat-libstdc++-33' do
  arch 'i686'
end

# package 'compat-libstdc++'

# yum_package 'compat-libstdc++' do
#  arch 'i686'
# end

package 'e2fsprogs'

package 'e2fsprogs-libs'

package 'glibc'

yum_package 'glibc' do
  arch 'i686'
end

package 'glibc-devel'

yum_package 'glibc-devel' do
  arch 'i686'
end

package 'ksh'

package 'libaio'

yum_package 'libaio' do
  arch 'i686'
end

package 'libaio-devel'

yum_package 'libaio-devel' do
  arch 'i686'
end

package 'libX11'

yum_package 'libX11' do
  arch 'i686'
end

package 'libXau'

yum_package 'libXau' do
  arch 'i686'
end

package 'libXi'

yum_package 'libXi' do
  arch 'i686'
  options '--setopt=protected_multilib=false'
end

package 'libXtst'

yum_package 'libXtst' do
  arch 'i686'
  options '--setopt=protected_multilib=false'
end

package 'gcc'

package 'gcc-c++'

package 'libgcc'

yum_package 'libgcc' do
  arch 'i686'
end

package 'libstdc++-devel'

yum_package 'libstdc++-devel' do
  arch 'i686'
end

package 'libxcb'

yum_package 'libxcb' do
  arch 'i686'
  options '--setopt=protected_multilib=false'
end

package 'make'

package 'sysstat'
