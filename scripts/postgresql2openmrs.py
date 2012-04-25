import db

import MySQLdb

#Postgres Database
host="localhost"
login='postgres'
password="password"
database='uamuzibora'

#Mysql Database
host_m="localhost"
login_m="root"
password_m="password"
database_m="openmrs_ub_alpha"



#
creator=1
location=3#Kakamega



database_pg=db.DB(host,login,password,database)
database_my=db.DB(host=host_m,user=login_m,password=password_m,database=database_m,driver="mysql")


all_patients= database_pg.query_dict("Select * from patients")


i=1
for patient in all_patients:

    created=patient['created']

    #Person table
    gender=None
    if patient['sex'] in ['Male','M','male','m']:
        gender="M"
    elif patient['sex'] in ['Female','female','f','F']:
        gender="F"
    new_person={'gender':gender,'birthdate':patient['date_of_birth'],'date_created':created,'creator':creator,'uuid':'hei'}
    person_id=database_my.insert('person',new_person)
    database_my.cursor.execute("UPDATE person SET uuid = uuid() WHERE uuid='hei'")
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

    #Patient
    new_patient={'patient_id':person_id,'creator':creator,'date_created':created}
    patient_id=database_my.insert('patient',new_patient)

    #UPN
    if patient['upn'].find('-')!=-1:
        upn=patient['upn']
    else:
        upn=str(patient['upn'])
        upn=upn[0:7]+'-'+upn[8:]
    new_patient_identifier={'patient_id':patient_id,'identifier':upn,'identifier_type':4,'creator':creator,'date_created':created,'location_id':location,'uuid':'hei'}
    patient_identifier_id=database_my.insert('patient_identifier',new_patient_identifier)
    database_my.cursor.execute("UPDATE patient_identifier SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()
#    if i==1:
#        import sys
#        sys.exit(0)
    
