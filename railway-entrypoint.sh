#!/bin/sh
# Keep exactly one Apache MPM (prefork, required by mod_php), then hand over to
# the upstream entrypoint unchanged.
for m in mpm_event mpm_worker; do
  rm -f "/etc/apache2/mods-enabled/$m.load" "/etc/apache2/mods-enabled/$m.conf"
done
exec house-entrypoint "$@"
