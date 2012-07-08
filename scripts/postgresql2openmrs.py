import db

import MySQLdb
import sys

#Postgres Database
host="localhost"
login='username'
password="password"
database='uamuzibora'

#Mysql Database
host_m="localhost"
login_m="user"
password_m="pass"
database_m="openmrs"
#
creator=1
location=1#Kakamega PGH
database_pg=db.DB(host,login,password,database)
database_my=db.DB(host=host_m,user=login_m,password=password_m,database=database_m,driver="mysql")

attribute={'telephone_number':8,'marital_status':5} # attribute type: code

# Set MySQL foreign_key_checks off, otherwise this gig won't work
database_my.cursor.execute("SET foreign_key_checks = 0;")
database_my.connection.commit()


def new_person_attribute(person_id,attribute_type,value,date):
    if value:
        if attribute_type=="marital_status":
            value=mariage_status[value]
        attype=attribute[attribute_type]
        new_person_attribute={'person_id':person_id,'value':value,'creator':creator,'date_created':date,'person_attribute_type_id':attype,'uuid':'hei'}
        database_my.insert('person_attribute',new_person_attribute)
        database_my.cursor.execute("UPDATE person_attribute SET uuid = uuid() WHERE uuid='hei'")
        database_my.connection.commit()


question_concept_ids=[]



mariage_status=[1057,6244,6243,1060,1058,1059]

all_patients= database_pg.query_dict("Select * from patients")

## Start of big loop
i=1
for patient in all_patients:

    created=patient['created']
    medical_information=database_pg.query_dict("SELECT * from medical_informations where pid = %s",patient['pid'])[0]
    
    #Person table
    gender=None
    if patient['sex'] in ['Male','M','male','m']:
        gender="M"
    elif patient['sex'] in ['Female','female','f','F']:
        gender="F"
    
    # Find out if they're alive or dead
    if patient['status'] is False and patient['inactive_reason_id'] == 4:
        print 'Old UPN:' + patient['upn'] + " - Fatality!"
        # Ok, so they're dead
        dead = 1
        death_date = patient['status_timestamp']
        new_person = {'gender':gender,'birthdate':patient['date_of_birth'],'dead':dead,'death_date':death_date,'date_created':created,'creator':creator,'uuid':'hei'}
        person_id = database_my.insert('person',new_person)
        # We also need to mark them as having "Exited from Care" as well
        # This needs an Observation to be created in the obs table:
        new_obs={'person_id':person_id,'concept_id':6153,'obs_datetime':death_date,'location_id':1,'value_coded':159,'value_coded_name_id':159,'date_created':death_date,'creator':creator,'uuid':'foo'}
        status_obs=database_my.insert('obs',new_obs)
    elif patient['status'] is False:
        print 'Old UPN:' + patient['upn'] + " - Alive but INACTIVE"
        # So they're alive, but we still don't know what their program status is (some of these patients will be inactive)
        new_person={'gender':gender,'birthdate':patient['date_of_birth'],'date_created':created,'creator':creator,'uuid':'hei'}
        person_id = database_my.insert('person',new_person)
        # TODO: Lookup status in patient['inactive_reason'] and update the HIV program status as appropriate
        # see previous new_obs expression above
        # inactive_reasons:
        #0;"None"
        #1;"Default (1 month)"
        #2;"Lost to Follow Up (3 months)"
        #3;"Stop"
        #4;"Deceased"
        #5;"PEP End"
        #6;"PMTCT End"
        #7;"Lost to Follow-up"
        #8;"Transfer Out"
        #9;"Stopped by Physician"
        #10;"Stopped as Duplicate Record"
    elif patient['status'] is True:
        print 'Old UPN:' + patient['upn']
        # Therefore, patient is alive and active: create a normal record.
        new_person={'gender':gender,'birthdate':patient['date_of_birth'],'date_created':created,'creator':creator,'uuid':'hei'}
        person_id = database_my.insert('person',new_person)
    else:
        # We really shouldn't be here: all use cases should have been covered by the options above...
        print "ERROR: Unknown patient status."
        sys.exit(0)

    database_my.cursor.execute("UPDATE person SET uuid = uuid() WHERE uuid='hei'")
    database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='foo'")
    database_my.connection.commit()


    #Person Name:
    forenames=patient['forenames'].split()
    if len(forenames)>1:
        forename=forenames[0]
        midlename=''
        for i in range(1,len(forenames)):
            midlename+=forenames[i]
            if i<len(forenames)-1:
                midlename+=' '
    else:
        forename=forenames[0]
        midlename=None
    new_name={'family_name':patient['surname'],'person_id':person_id,'creator':creator,'date_created':created,'given_name':forename,'middle_name':midlename,'uuid':'hei'}
    person_name_id=database_my.insert('person_name',new_name)
    database_my.cursor.execute("UPDATE person_name SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()

    # Patient
    new_patient={'patient_id':person_id,'creator':creator,'date_created':created}
    patient_id=database_my.insert('patient',new_patient)

    # UPN
    if patient['upn'].find('-')!=-1:
        upn=str(patient['upn'])
        upn1,upn2=upn.split(upn)
        upn=upn1[0:5]+"-"+upn2
    else:
        upn=str(patient['upn'])
        upn=upn[0:6]+'-'+upn[8:] # [0:5] as we have a new format for UPN
    new_patient_identifier={'patient_id':person_id,'identifier':upn,'identifier_type':3,'preferred':3,'creator':creator,'date_created':created,'location_id':location,'uuid':'hei'}

    patient_identifier_id=database_my.insert('patient_identifier',new_patient_identifier)
    database_my.cursor.execute("UPDATE patient_identifier SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()
    
    # Person attributes
    new_person_attribute(person_id,'telephone_number',patient['telephone_number'],created)
    new_person_attribute(person_id,'marital_status',patient['marital_status_id'],created)


    # Address
    location_id=patient['location_id']
    locations=database_pg.query_dict('Select * from locations where id= %s',location_id)

    while locations[-1]['parent_id']:
        locations.append(database_pg.query_dict('Select * from locations where id= %s',locations[-1]['parent_id'])[0])
    if len(locations)<4:
        locations=[{'name':None},{'name':None},{'name':None},{'name':None}]
    #print locations
    new_person_address={'person_id':person_id,'preferred':1,'address1':patient['home'],'address2':patient['nearest_major_landmark'],'creator':creator,'date_created':created,'county_district':locations[-2]['name'],'address3':patient['nearest_health_centre'],'address5':locations[-4]['name'],'address6':locations[-3]['name'],'uuid':'hei'}
    database_my.insert('person_address',new_person_address)
    database_my.cursor.execute("UPDATE person_address SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()
    
    # Initial Encounter
    # Things we need:
    #   1. Entry Point
    #   2. Date Registered/Transferred In
    #   3. Date HIV positive
    #   4. Date eligible for ART
    #   5. Treatment Supporter Name
    #   6. Treatment Supporter Postal Address
    #   7. Treatment Supporter Telephone Number

    # +INSERT INTO `encounter` VALUES (1,1,2,1,1,'2012-07-08 00:00:00',1,'2012-07-08 19:01:32',0,NULL,NULL,NULL,NULL,NULL,NULL,'780f9769-58a3-4541-b231-012626fa6e35');
    
    # +INSERT INTO `obs` VALUES (2,2,6253,1,NULL,'2012-07-08 00:00:00',1,NULL,NULL,NULL,NULL,970,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2012-07-08 19:01:32',0,NULL,NULL,NULL,'10985627-cadb-4f1e-9ad3-260334ded809
    # +INSERT INTO `obs` VALUES (3,2,6255,1,NULL,'2012-07-08 00:00:00',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'987654321',NULL,NULL,1,'2012-07-08 19:01:32',0,NULL,NULL,NULL,'237aa525-0ef2-40e7-8a11-b90b
    # +INSERT INTO `obs` VALUES (4,2,6254,1,NULL,'2012-07-08 00:00:00',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A Treatment Supporter Address',NULL,NULL,1,'2012-07-08 19:01:32',0,NULL,NULL,NULL,'4a9444fa
    # +INSERT INTO `obs` VALUES (5,2,6252,1,NULL,'2012-07-08 00:00:00',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A Treatment Supporters Name',NULL,NULL,1,'2012-07-08 19:01:32',0,NULL,NULL,NULL,'010efeaa-5
    
    # Make our initial encounter record
    initial_encounter={'encounter_type':1,'patient_id':person_id,'location_id':1,'form_id':1,'encounter_datetime':patient['created'],'creator':creator,'date_created':patient['created'],'uuid':'hei'}
    initial_encounter_id=database_my.insert('encounter',initial_encounter)
    database_my.cursor.execute("UPDATE encounter SET uuid = uuid() WHERE uuid='hei'")

    # Treatment Supporter
    if patient['treatment_supporter_name']:
        ts_name = {'person_id':person_id,'concept_id':6252,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_name'],'date_created':patient['created'],'creator':creator,'uuid':'hei'}
        intial_encounter_id=database_my.insert('obs',ts_name)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")
    if patient['treatment_supporter_address']:
        ts_address = {'person_id':person_id,'concept_id':6254,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_address'],'date_created':patient['created'],'creator':creator,'uuid':'hei'}
        intial_encounter_id=database_my.insert('obs',ts_address)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")
    if patient['treatment_supporter_telephone_number']:
        ts_telephone = {'person_id':person_id,'concept_id':6255,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_telephone_number'],'date_created':patient['created'],'creator':creator,'uuid':'hei'}
        intial_encounter_id=database_my.insert('obs',ts_telephone)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")

    #medinfo=database_pg.query_dict('select * from medical_informations where pid= %s', patient['pid'])
    #if medinfo:
        # So we've found the medinfo for this pt

        # Construct our obs records
        
    #patient_identifier_id=database_my.insert('encounter',initial_encounter)
    #database_my.cursor.execute("UPDATE encounter SET uuid = uuid() WHERE uuid='hei'")
    #database_my.connection.commit()

    # Add patient to program
    # ACTIVE:
    # +INSERT INTO `patient_program` VALUES (1,2,1,'2012-07-01 00:00:00',NULL,1,NULL,1,'2012-07-08 09:01:19',NULL,NULL,0,NULL,NULL,NULL,'d1a1bf39-9f1a-49e0-8feb-61ae79e5d58e');
    # INACTIVE:
    # +INSERT INTO `patient_program` VALUES (1,2,1,'2012-07-01 00:00:00','2012-07-10 00:00:00',1,NULL,1,'2012-07-08 09:01:19',1,'2012-07-08 09:03:04',0,NULL,NULL,NULL,'d1a1bf39-9f1a-49e0-8feb-61ae79e5d58e');
    # +INSERT INTO `obs` VALUES (1,2,6153,NULL,NULL,'2012-07-08 00:00:00',1,NULL,NULL,NULL,NULL,1285,1285,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2012-07-08 09:03:21',0,NULL,NULL,NULL,'8132e669-33e9-4dcd-8e02-61c2a9f7
 
# Set MySQL foreign_key_checks on again
database_my.cursor.execute("SET foreign_key_checks = 1;")
database_my.connection.commit()
