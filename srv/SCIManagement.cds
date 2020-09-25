using {
  SCI_TP0010  as TP0010,
  SCI_MST0010 as MST0010,
  SCI_MST0020 as MST0020
} from '../db/SCIManagement';


service SCIManagementService {

  entity SCI_TP_INTERFACELIST_SRV as projection on TP0010 {
    * ,
    STATUS_CD       : redirected to SCI_MST_CODE_SRV, 
    SC_SYS_FK       : redirected to SCI_MST_SYSTEMLIST_SRV, 
    SC_IFTYPE_CD    : redirected to SCI_MST_CODE_SRV, 
    TG_SYS_FK       : redirected to SCI_MST_SYSTEMLIST_SRV, 
    TG_IFTYPE_CD    : redirected to SCI_MST_CODE_SRV, 
    EXECUTION_CD    : redirected to SCI_MST_CODE_SRV, 
    BATCHCYCLE_CD   : redirected to SCI_MST_CODE_SRV
  };


  entity SCI_MST_CODE_SRV         as projection on MST0010;

  view SCI_VH_CODE_COMPANY_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false
      and CAT01 = 'COMPANY'
      and (CAT02 = '' or CAT02 IS NULL);

  view SCI_VH_CODE_SUBSIDARY_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'COMPANY'
      and CAT02 = 'SUBSIDARY'
      and (CAT03 = '' or CAT03 IS NULL);

  view SCI_VH_CODE_APPLICATIONTYPE_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'APPLICATION'
      and CAT02 = 'TYPE'
      and (CAT03 = '' or CAT03 IS NULL);


  view SCI_VH_CODE_IFSTATUS_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'INTERFACE'
      and CAT02 = 'STATUS'
      and (CAT03 = '' or CAT03 IS NULL);
  
  view SCI_VH_CODE_IFPROTOCOL_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'INTERFACE'
      and CAT02 = 'PROTOCOL'
      and (CAT03 = '' or CAT03 IS NULL);

  view SCI_VH_CODE_IFEXECUTION_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'INTERFACE'
      and CAT02 = 'EXECUTION'
      and (CAT03 = '' or CAT03 IS NULL);

  view SCI_VH_CODE_IFCYCLE_SRV as select from MST0010 excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false 
      and CAT01 = 'INTERFACE'
      and CAT02 = 'CYCLE'
      and (CAT03 = '' or CAT03 IS NULL);

  entity SCI_MST_SYSTEMLIST_SRV   as projection on MST0020 {
    * ,
    COMPANY_CD   : redirected to SCI_MST_CODE_SRV, 
    SUBSIDARY_CD : redirected to SCI_MST_CODE_SRV, 
    APPPLTYPE_CD : redirected to SCI_MST_CODE_SRV
  };


  entity SCI_VH_SYSTEMLIST_SRV    as projection on MST0020 {
    * ,
    COMPANY_CD   : redirected to SCI_MST_CODE_SRV, 
    SUBSIDARY_CD : redirected to SCI_MST_CODE_SRV, 
    APPPLTYPE_CD : redirected to SCI_MST_CODE_SRV
  }excluding {
    DELETED_TF,
    HISTORY
  } where DELETED_TF = false;

  @requires : 'authenticated-user'
  action sendErrorEmail();
}
