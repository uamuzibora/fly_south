import db

import MySQLdb

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



mariage_status=[1057,1055,1055,1060,1058,1069]

all_patients= database_pg.query_dict("Select * from patients")


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
        upn=str(patient['upn'])
        upn1,upn2=upn.split(upn)
        upn=upn1[0:5]+"-"+upn2
    else:
        upn=str(patient['upn'])
        upn=upn[0:5]+'-'+upn[8:] # [0:5] as we have a new format for UPN
    new_patient_identifier={'patient_id':patient_id,'identifier':upn,'identifier_type':4,'creator':creator,'date_created':created,'location_id':location,'uuid':'hei'}

    patient_identifier_id=database_my.insert('patient_identifier',new_patient_identifier)
    database_my.cursor.execute("UPDATE patient_identifier SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()
    
    #Person attributes
    
    new_person_attribute(person_id,'telephone_number',patient['telephone_number'],created)
    new_person_attribute(person_id,'marital_status',patient['marital_status_id'],created)
#    new_person_attribute(person_id,'date_arv_eligible',medical_information['art_eligibility_date'],created)


    #ADRESS
    location_id=patient['location_id']
    locations=database_pg.query_dict('Select * from locations where id= %s',location_id)

    while locations[-1]['parent_id']:
        locations.append(database_pg.query_dict('Select * from locations where id= %s',locations[-1]['parent_id'])[0])
    if len(locations)<4:
        locations=[{'name':None},{'name':None},{'name':None},{'name':None}]
    new_person_address={'person_id':person_id,'address1':patient['home'],'creator':creator,'address2':patient['nearest_major_landmark'],'address3':patient['nearest_health_centre'],'address5':locations[-4]['name'],'address6':locations[-3]['name'],'county_district':locations[-2]['name'],'date_created':created,'uuid':'hei'}
    database_my.insert('person_address',new_person_address)
    database_my.cursor.execute("UPDATE person_address SET uuid = uuid() WHERE uuid='hei'")
    database_my.connection.commit()
    
    #Treatment Supporter:
    #Option 1: create new person

    #Option 2: Attributes
#    new_person_attribute(person_id,'treatment_supporter_name',patient['treatment_supporter_name'],created)
#    new_person_attribute(person_id,'treatment_supporter_relationship',patient['treatment_supporter_relationship'],created)
#    new_person_attribute(person_id,'treatment_supporter_address',patient['treatment_supporter_address'],created)
#    new_person_attribute(person_id,'treatment_supporter_telephone_number',patient['treatment_supporter_telephone_number'],created)




#    if i==1:
#        import sys
#        sys.exit(0)

# Set MySQL foreign_key_checks on again
database_my.cursor.execute("SET foreign_key_checks = 1;")
database_my.connection.commit()
