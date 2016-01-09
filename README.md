sf-db-tools extension provides a set of simple scripts to manage MySQL and
Postgres database servers:

- quickly create new database and associated user
- dump and restore database contents
- replicate database between servers

These scripts are suitable for development/testing/integration purposes, but
NOT suitable for production purposess, or in case your database holds sensitive
data, as they provide simplified security model, conceived for rapid development.

MySQL scripts rely on debian-sys-maint user, which exists by default on MySQL
servers installed on Debian/Ubuntu/Mint from system repositories.

Postgres scripts rely on peer authentication, which is enabled by default on
most Linux installations.
