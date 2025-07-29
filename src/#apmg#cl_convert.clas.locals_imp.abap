CLASS lcl_utils DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS to_typetext
      IMPORTING
        !typekind     TYPE abap_typekind
        !is_long      TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS validate_encoding
      IMPORTING
        !encoding TYPE string
      RAISING
        /apmg/cx_error.

    CLASS-METHODS validate_timezone
      IMPORTING
        !timezone TYPE string
      RAISING
        /apmg/cx_error.

    CLASS-METHODS is_timestamp
      IMPORTING
        !data         TYPE any
        !long         TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result) TYPE abap_bool.

ENDCLASS.

CLASS lcl_utils IMPLEMENTATION.

  METHOD to_typetext.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_char.
        IF is_long = abap_true.
          result = 'text field'(101).
        ELSE.
          result = 'character'(001).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_clike.
        result = 'character-like'(002).
      WHEN cl_abap_typedescr=>typekind_csequence.
        result = 'text-like'(003).
      WHEN cl_abap_typedescr=>typekind_date.
        IF is_long = abap_true.
          result = 'date field'(104).
        ELSE.
          result = 'date'(004).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_decfloat.
        IF is_long = abap_true.
          result = 'decimal floating point number'(105).
        ELSE.
          result = 'decfloat'(005).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_decfloat16.
        IF is_long = abap_true.
          result = 'decimal floating point number with 16 places'(106).
        ELSE.
          result = 'decfloat16'(006).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_decfloat34.
        IF is_long = abap_true.
          result = 'decimal floating point number with 34 places'(107).
        ELSE.
          result = 'decfloat34'(007).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_float.
        IF is_long = abap_true.
          result = 'binary floating point number with 17 places'(108).
        ELSE.
          result = 'float'(008).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_hex.
        IF is_long = abap_true.
          result = 'byte field'(109).
        ELSE.
          result = 'byte'(009).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_int.
        IF is_long = abap_true.
          result = '4-byte integer'(110).
        ELSE.
          result = 'integer'(010).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_int1.
        result = '1-byte integer'(011).
      WHEN cl_abap_typedescr=>typekind_int2.
        result = '2-byte integer'(012).
      WHEN cl_abap_typedescr=>typekind_int8.
        result = '4-byte integer'(013).
      WHEN cl_abap_typedescr=>typekind_num.
        IF is_long = abap_true.
          result = 'numeric text field'(114).
        ELSE.
          result = 'num'(014).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_numeric.
        result = 'numeric'(015).
      WHEN cl_abap_typedescr=>typekind_packed.
        IF is_long = abap_true.
          result = 'packed number'(116).
        ELSE.
          result = 'packed'(016).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_simple.
        result = 'simple'(017).
      WHEN cl_abap_typedescr=>typekind_string.
        IF is_long = abap_true.
          result = 'text string'(118).
        ELSE.
          result = 'string'(018).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_struct1.
        result = 'flat structure'(019).
      WHEN cl_abap_typedescr=>typekind_struct2.
        result = 'deep structure'(020).
      WHEN cl_abap_typedescr=>typekind_table.
        result = 'table'(021).
      WHEN cl_abap_typedescr=>typekind_time.
        IF is_long = abap_true.
          result = 'time field'(122).
        ELSE.
          result = 'time'(022).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_utclong.
        result = 'timestamp'(023).
      WHEN cl_abap_typedescr=>typekind_w.
        result = 'wide character'(024).
      WHEN cl_abap_typedescr=>typekind_xsequence.
        result = 'byte-like'(025).
      WHEN cl_abap_typedescr=>typekind_xstring.
        IF is_long = abap_true.
          result = 'byte string'(126).
        ELSE.
          result = 'xstring'(026).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_any.
        IF is_long = abap_true.
          result = 'any type'(127).
        ELSE.
          result = 'any'(027).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_class.
        result = 'class'(028).
      WHEN cl_abap_typedescr=>typekind_data.
        result = 'data object'(029).
      WHEN cl_abap_typedescr=>typekind_dref.
        result = 'data reference'(030).
      WHEN cl_abap_typedescr=>typekind_intf.
        result = 'interface'(031).
      WHEN cl_abap_typedescr=>typekind_iref.
        result = 'interface reference'(032).
      WHEN cl_abap_typedescr=>typekind_oref.
        result = 'object reference'(033).
      WHEN cl_abap_typedescr=>typekind_bref.
        IF is_long = abap_true.
          result = 'boxed component'(134).
        ELSE.
          result = 'boxed'(034).
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_enum.
        IF is_long = abap_true.
          result = 'enumeration'(135).
        ELSE.
          result = 'enum'(035).
        ENDIF.
      WHEN OTHERS.
        ASSERT 1 = 2.
    ENDCASE.

  ENDMETHOD.

  METHOD validate_encoding.

    CASE encoding.
      WHEN /apmg/cl_convert=>c_encoding-ascii
        OR /apmg/cl_convert=>c_encoding-utf_8
        OR /apmg/cl_convert=>c_encoding-utf_16_be
        OR /apmg/cl_convert=>c_encoding-utf_16_le
        OR /apmg/cl_convert=>c_encoding-utf_32_be
        OR /apmg/cl_convert=>c_encoding-utf_32_le
        OR ''.
        RETURN.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = |Unkown encoding: { encoding }|.
    ENDCASE.

  ENDMETHOD.

  METHOD validate_timezone.

    SELECT COUNT(*) FROM ttzz INTO @DATA(count)
      WHERE tzone = @timezone AND flagactive = @abap_true.
    IF count <> 1.
      RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = |Too many timezones|.
    ENDIF.

  ENDMETHOD.

  METHOD is_timestamp.

    DATA(type_descr) = cl_abap_typedescr=>describe_by_data( data ).

    IF type_descr->type_kind = cl_abap_typedescr=>typekind_packed.
      DATA(packed) = CAST cl_abap_elemdescr( type_descr ).
      IF long = abap_true.
        result = xsdbool( packed->length = 11 AND packed->decimals = 7 ).
      ELSE.
        result = xsdbool( packed->length = 8 AND packed->decimals = 0 ).
      ENDIF.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
