class ZCM_RAP_NP definition
  public
  create private .

public section.
protected section.
private section.
ENDCLASS.



CLASS ZCM_RAP_NP IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->begindate = begindate.
    me->enddate = enddate.
    me->travelid = |{ travelid ALPHA = OUT }|.
    me->customerid = |{ customerid ALPHA = OUT }|.
    me->agencyid = |{ agencyid ALPHA = OUT }|.

  ENDMETHOD.
ENDCLASS.
