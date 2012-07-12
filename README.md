fly-south
=========

A Python migration script for [Uamuzi Bora][1] from our [CakePHP][2] app
to [OpenMRS 1.9.0][3].

Background
----------
When switching platforms from our [in-house developed EMR][4] to
[OpenMRS][3], we needed to migrate our existing database containing ~7,100
patients with ~300,000 observations to OpenMRS' schema.

Solution
--------
**fly-south** is a rudimentary Python script that imports all patients
and selected observations from our existing PostgreSQL database
into our [new schema][5] in OpenMRS.

It uses [Gunnar's][6] excellent **db.py**, a Python database abstraction
module for MySQL and PostgreSQL.

Further Use
-----------
Due to the niche use-case of this script, it's unlikely to be of much use
elsewhere in its present form, but if you're trying to import data from
an existing EMR into OpenMRS, it may illustrate one approach to a
solution.

Disclaimer & License
--------------------
 * tl;dr: **Use at your own risk!**
 * You are free to use **fly-south** in any way you see fit, as long as you respect the terms of the license.
  * [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) - see the LICENSE file for further details.
 * This is some rather ugly code; it was written in a hurry to meet a deadline 

[1]: http://uamuzibora.com
[2]: http://cakephp.org
[3]: http://openmrs.org
[4]: https://github.com/uamuzibora/uamuzi-bora
[5]: https://github.com/uamuzibora/nafasi
[6]: https://github.com/gulfa