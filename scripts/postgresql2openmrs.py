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



mariage_status = [1057,6244,6243,1060,1058,1059]

status_status = [5622,6154,5240,6155,159,6156,1253,5240,1285,6158,6159] 

all_patients = database_pg.query_dict("Select * from patients")

## Start of big loop
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
    if patient['status'] is True:
        print 'Old UPN:' + patient['upn']
        # Therefore, patient is alive and active: create a normal record.
        new_person={'gender':gender,'birthdate':patient['date_of_birth'],'date_created':created,'creator':creator,'uuid':'hei'}
        person_id = database_my.insert('person',new_person)
    elif patient['status'] is False:
        if patient['inactive_reason_id'] == 4:
            # Ok, so they're dead
            print 'Old UPN:' + patient['upn'] + " - Fatality!"
            dead = 1
            death_date = patient['status_timestamp']
            new_person = {'gender':gender,'birthdate':patient['date_of_birth'],'dead':dead,'death_date':death_date,'date_created':created,'creator':creator,'uuid':'hei'}
            person_id = database_my.insert('person',new_person)
        else:
            # So they're alive but inactive for some reason other than being deceased
            print 'Old UPN:' + patient['upn'] + " - Alive but INACTIVE"
            new_person={'gender':gender,'birthdate':patient['date_of_birth'],'date_created':created,'creator':creator,'uuid':'hei'}
            person_id = database_my.insert('person',new_person)
        # Now we need to mark these patients as having "Exited from Care" as well by creating an appropriate observation
        status_concept_id = status_status[patient['inactive_reason_id']]
        status = {'person_id':person_id,'concept_id':6153,'obs_datetime':patient['status_timestamp'],'location_id':1,'value_coded':status_concept_id,'value_coded_name_id':status_concept_id,'date_created':patient['status_timestamp'],'creator':creator,'uuid':'foo'}
        status_id=database_my.insert('obs',status)
    else:
        # We really shouldn't be here: all use cases should have been covered by the options above...
        print "ERROR: Unknown patient status."
        sys.exit(1)
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

    # Make our initial encounter record
    initial_encounter={'encounter_type':1,'patient_id':person_id,'location_id':1,'form_id':1,'encounter_datetime':patient['created'],'creator':creator,'date_created':patient['created'],'uuid':'hei'}
    initial_encounter_id=database_my.insert('encounter',initial_encounter)
    database_my.cursor.execute("UPDATE encounter SET uuid = uuid() WHERE uuid='hei'")

    # Treatment Supporter
    if patient['treatment_supporter_name']:
        ts_name = {'person_id':person_id,'concept_id':6252,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_name'],'date_created':patient['created'],'creator':creator,'uuid':'hei1'}
        ts_name_id=database_my.insert('obs',ts_name)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei1'")
    if patient['treatment_supporter_address']:
        ts_address = {'person_id':person_id,'concept_id':6254,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_address'],'date_created':patient['created'],'creator':creator,'uuid':'hei2'}
        ts_address_id=database_my.insert('obs',ts_address)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei2'")
    if patient['treatment_supporter_telephone_number']:
        ts_telephone = {'person_id':person_id,'concept_id':6255,'encounter_id':initial_encounter_id,'obs_datetime':patient['created'],'location_id':1,'value_text':patient['treatment_supporter_telephone_number'],'date_created':patient['created'],'creator':creator,'uuid':'hei3'}
        ts_telephone_id=database_my.insert('obs',ts_telephone)
        database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei3'")

    # Pull medinfo
    medinfos = database_pg.query_dict('select * from medical_informations where pid= %s', patient['pid'])
    medinfo = medinfos[0]
    if medinfo:
        # So we've found the medinfo for this pt

        # Entry Point (patient_source_id) (6245)
        if medinfo['patient_source_id']:
            entry_point_concepts = ['foo',6246,6248,6247,5622,6249,5622,6250,5622,5622]
            entry_point_concept_id = entry_point_concepts[medinfo['patient_source_id']]
            entry_point = {'person_id':person_id,'concept_id':6245,'encounter_id':initial_encounter_id,'obs_datetime':medinfo['created'],'location_id':1,'value_coded':entry_point_concept_id,'date_created':medinfo['created'],'creator':creator,'uuid':'hei'}
            entry_point_id=database_my.insert('obs',entry_point)
            database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")
        
        # ** ADD PATIENT TO PROGRAM **
        # Date Registered/Transferred In (hiv_positive_clinic_start_date)
        if medinfo['hiv_positive_clinic_start_date']:
            reg_date = medinfo['hiv_positive_clinic_start_date']
        else:
             # If NULL, substitute in patient['created'] date
            reg_date = patient['created']

        # Let's enroll them in the HIV program
        if patient['status'] is True:
            # Alive and active
            hiv_program = {'patient_id':person_id,'program_id':1,'date_enrolled':reg_date,'location_id':1,'creator':creator,'date_created':medinfo['created'],'uuid':'hei'}
            hiv_program_id = database_my.insert('patient_program',hiv_program)
            database_my.cursor.execute("UPDATE patient_program SET uuid = uuid() WHERE uuid='hei'")
        elif patient['status'] is False:
            # Inactive (alive or deceased)
            hiv_program = {'patient_id':person_id,'program_id':1,'date_enrolled':reg_date,'date_completed':patient['status_timestamp'],'location_id':1,'creator':creator,'date_created':medinfo['created'],'uuid':'hei'}
            hiv_program_id = database_my.insert('patient_program',hiv_program)
            database_my.cursor.execute("UPDATE patient_program SET uuid = uuid() WHERE uuid='hei'")
        
        # Date HIV positive (hiv_positive_date) (6259)
        if medinfo['hiv_positive_date']:
            hiv_date = {'person_id':person_id,'concept_id':6259,'encounter_id':initial_encounter_id,'obs_datetime':medinfo['created'],'location_id':1,'value_datetime':medinfo['hiv_positive_date'],'date_created':medinfo['created'],'creator':creator,'uuid':'hei'}
            hiv_date_id=database_my.insert('obs',hiv_date)
            database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")
        
        # Date eligible for ART (art_eligibility_date) (6260)
        if medinfo['art_eligibility_date']:
            art_elig_date = {'person_id':person_id,'concept_id':6260,'encounter_id':initial_encounter_id,'obs_datetime':medinfo['created'],'location_id':1,'value_datetime':medinfo['art_eligibility_date'],'date_created':medinfo['created'],'creator':creator,'uuid':'hei'}
            art_elig_date_id=database_my.insert('obs',art_elig_date)
            database_my.cursor.execute("UPDATE obs SET uuid = uuid() WHERE uuid='hei'")

    # BOOM! Initial encounter done. Cue small victory dance.


# Set MySQL foreign_key_checks on again
database_my.cursor.execute("SET foreign_key_checks = 1;")
database_my.connection.commit()
