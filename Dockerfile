# Railway wrapper around the unmodified upstream House Planner image
# (built from egmalt/house-planner@5c91280 by the GHCR workflow).
ARG BASE=ghcr.io/onepush-dev/house-planner:base-5c91280
FROM ${BASE}
# Railway: Apache refused to start with "More than one MPM loaded".
# mod_php needs prefork, so make sure it is the only MPM enabled.
RUN a2dismod -f mpm_event mpm_worker >/dev/null 2>&1 || true; a2enmod mpm_prefork >/dev/null
COPY railway-entrypoint.sh /usr/local/bin/railway-entrypoint
RUN chmod 0755 /usr/local/bin/railway-entrypoint
ENTRYPOINT ["railway-entrypoint"]
CMD ["apache2-foreground"]
