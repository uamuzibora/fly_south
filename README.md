fly-south
=========

Migration toolkit for [Uamuzi Bora][1] from [CakePHP][2] to [OpenMRS][3].

**KEEP THIS REPO SECURE AS THE SQL DUMPS MAY CONTAIN PATIENT-IDENTIFIABLE DATA DURING DEVELOPMENT**

See [the wiki][4] for in-depth details.

## Quick(ish)start

 1. Clone this repo (if you haven't done so already)
 2. Download [OpenMRS Standalone v1.8.3][5] (same download for Linux, Mac OS X & Windows)
  - Do *not* start it running yet (see further instructions below)
 3. Run a local instance of [Uamuzi Bora v0.3][6] (as deployed by Gunnar in 2010) using PostgreSQL as a db
  - Commit: [08f849450d0dc132a516692fa66e9ef53c6b78c2][6]
  - _We're running PostgreSQL 8.3 on our production server, but there **shouldn't** be a difference if you're running a newer version._
 4. Run MySQL 5.5 (or higher)
 5. Run the following commands via the command-line `mysql` client and then quit the client after running:
  - `SET GLOBAL sql_mode='NO_AUTO_VALUE_ON_ZERO';`
  - `SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';`
  - _This is because MySQL (cf PostgreSQL) assigns special importance to `0` values in autoincrementing columns which we want to disable, otherwise it breaks._
 6. Import the MySQL version of our CakePHP schema (the user will need `CREATE SCHEMA` privileges as it creates it's own database called `public`): [cakephp-mysql.sql][7]
  - `mysql -u root -p < cakephp-mysql.sql`
 7. Make sure you have some patient data in your PostgreSQL db used by your local instance of Uamuzi Bora (so we have some practice data to work with)
 8. Copy the OpenMRS config file from this repo into the root directory of your unzipped copy of OpenMRS Standalone:
  - `cp openmrs/openmrs-standalone-runtime.properties /path/to/your/openmrs-standalone-1.8.3/`
  - _This configures the OpenMRS to use your local MySQL server on port 3306 rather than the MySQL server bundled with OpenMRS that is the default option and runs on port 3316. We want to use our locally installed MySQL server for persistent storage of our schema beyond the lifetime of the instance of OpenMRS._
 9. Import our customised version of the OpenMRS MySQL database schema: [openmrs-ub.sql][8]
  - Contains the recreated Uamuzi Bora _schema_ but has _no_ patient records (apart from a couple of test patients).
 10. Launch OpenMRS: `java -jar standalone-1.1.jar`
  - This will start the Installation Wizard. **You will need to change a few settings!**
## Game Plan
 1. Create a script to move the CakePHP database schema and content from PostgreSQL to MySQL.
  - **Not** urgent as manual solution is not too laborious at present.
 2. Create a script to import data from CakePHP MySQL database into OpenMRS' PostgreSQL schema. This will be complicated and likely require several stages.
  1. Import limited basic patient demographics and assign identifiers.
  2. Import our `public.results` table (and data from referenced tables e.g. `public.result_values`).
   - NB: The equivalent of `public.tests` and `result_lookups` have been recreated manually in OpenMRS, so are already present

## Moving target
Some issues regarding migrating:
 - The paper form used as the clinics hard copy (MoH 257) has changed to a new version.
  - Some fields have been removed, some have been added.
 - The OpenMRS data model is *much* more complicated than CakePHP's (but is better normalized) 
 - We don't need to transfer *all* data from CakePHP - some fields are now irrevelant or no longer useful or impracticle to transfer.
 
[1]: http://uamuzibora.com
[2]: http://cakephp.org
[3]: http://openmrs.org
[4]: https://github.com/uamuzibora/fly-south/wiki
[5]: http://sourceforge.net/projects/openmrs/files/releases/OpenMRS_1.8.3/openmrs-standalone-1.8.3.zip/download
[6]: https://github.com/uamuzibora/uamuzi-bora/commit/08f849450d0dc132a516692fa66e9ef53c6b78c2
[7]: https://github.com/uamuzibora/fly-south/blob/master/sql/cakephp-mysql.sql