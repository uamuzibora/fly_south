fly-south
=========

Migration toolkit for [Uamuzi Bora][1] from [CakePHP][2] to [OpenMRS][3].

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
  - `mysql -u root -p < sql/cakephp-mysql.sql`
 7. Make sure you have some patient data in your PostgreSQL db used by your local instance of Uamuzi Bora (so we have some practice data to work with)
 8. Copy the OpenMRS config file from this repo into the root directory of your unzipped copy of OpenMRS Standalone:
  - `cp openmrs/openmrs-standalone-runtime.properties /path/to/your/openmrs-standalone-1.8.3/`
  - _This configures the OpenMRS to use your local MySQL server on port 3306 rather than the MySQL server bundled with OpenMRS that is the default option and runs on port 3316. We want to use our locally installed MySQL server for persistent storage of our schema beyond the lifetime of the instance of OpenMRS._
 9. Import our customised version of the OpenMRS MySQL database schema: [openmrs-ub.sql][8]
  - Contains the recreated Uamuzi Bora _schema_ but has _no_ patient records (apart from a couple of test patients).
  - Again, the user will need `CREATE SCHEMA` privileges as it creates it's own database called `openmrs`.
  - - `mysql -u root -p < sql/openmrs-ub.sql`
 10. Launch OpenMRS: `java -jar standalone-1.1.jar` **You will need to change some settings as detailed below**
  1. Keep Tomcat port & MySQL port in the Java app window at their defaults (we will change the MySQL port shortly)
  2. Choose **Expert Mode** when prompted.
  3. **Step 1 of 6**:
   - Database Connection: `jdbc:mysql://localhost:3306/@DBNAME@...` i.e. ensure that the port is **3306** for your local instance of MySQL.
   - Choose **Yes** with Database Name `openmrs`
  4. **Step 2 of 6**:
   - No: do not create tables automagically
   - No: do not add demo data
   - You can choose to either let the wizard create a user for openmrs or specify a user for use. We use a user `openmrs` with password `test`
  5. **Step 3 of 6**:
   - Yes: Able to upload web modules
   - No: do not update db automatically following new web application deployment.
  6. **Step 4 of 6**:
   - _Step 4 appears to be skipped in this configuration_
  7. **Step 5 of 6**:
   - _Keep all fields blank_
  8. **Step 6 of 6**:
   - Finish: wait for page to refresh automagically after clicking.
   - Login with default details - user `admin`, pass `test`
 11. You're good to go
 

[1]: http://uamuzibora.com
[2]: http://cakephp.org
[3]: http://openmrs.org
[4]: https://github.com/uamuzibora/fly-south/wiki
[5]: http://sourceforge.net/projects/openmrs/files/releases/OpenMRS_1.8.3/openmrs-standalone-1.8.3.zip/download
[6]: https://github.com/uamuzibora/uamuzi-bora/commit/08f849450d0dc132a516692fa66e9ef53c6b78c2
[7]: https://github.com/uamuzibora/fly-south/blob/master/sql/cakephp-mysql.sql
[8]: https://github.com/uamuzibora/fly-south/blob/master/sql/openmrs-ub.sql