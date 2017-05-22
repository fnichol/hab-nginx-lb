pkg_name=nginx-lb
pkg_version=1.13.0
pkg_description="An nginx dynamic service load balancer for Habitat services"
pkg_maintainer="Seth Vargo <seth@sethvargo.com>"
pkg_license=('bsd')
pkg_upstream_url=https://nginx.org/
pkg_dirname="nginx-${pkg_version}"
pkg_deps=(core/nginx)
pkg_build_deps=(core/coreutils)
pkg_svc_run="nginx -c ${pkg_svc_config_path}/nginx.conf"
pkg_svc_user="root"
pkg_exports=(
  [port]=http.port
)
pkg_exposes=(port)
pkg_binds=(
  [backend]="port"
)

do_build() {
  return 0
}

do_install() {
  return 0
}
