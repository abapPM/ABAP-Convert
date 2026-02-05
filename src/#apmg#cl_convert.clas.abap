CLASS /apmg/cl_convert DEFINITION PUBLIC CREATE PUBLIC.

************************************************************************
* Convert Any Data Type
*
* Copyright 2024 apm.to Inc. <https://apm.to>
* SPDX-License-Identifier: MIT
************************************************************************

  " TODO!: Add test cases for 100% coverage
  " TODO: Replace cx_root with more specific exceptions
  " FUTURE: Add to_codepage conversions CL_ABAP_CODEPAGE

  PUBLIC SECTION.

    CONSTANTS c_version TYPE string VALUE '1.0.0' ##NEEDED.

    CONSTANTS:
      BEGIN OF c_encoding,
        ascii     TYPE string VALUE 'ASCII',
        utf_8     TYPE string VALUE 'UTF8',
        utf_16_be TYPE string VALUE 'UTF16BE',
        utf_16_le TYPE string VALUE 'UTF16LE',
        utf_32_be TYPE string VALUE 'UTF32BE',
        utf_32_le TYPE string VALUE 'UTF32LE',
      END OF c_encoding.

    CONSTANTS:
      " TODO?: We could add all timezones here (~90 in TTZZ)
      BEGIN OF c_timezone,
        utc TYPE string VALUE 'UTC',
      END OF c_timezone.

    TYPES:
      BEGIN OF ty_options,
        trim_strings TYPE abap_bool,
      END OF ty_options.

    CLASS-METHODS create
      IMPORTING
        !data         TYPE any
        !options      TYPE ty_options OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO /apmg/cl_convert.

    METHODS constructor
      IMPORTING
        !data    TYPE any
        !options TYPE ty_options OPTIONAL.

    METHODS from
      IMPORTING
        !data         TYPE any
      RETURNING
        VALUE(result) TYPE REF TO /apmg/cl_convert.

    METHODS to_char
      CHANGING
        !result TYPE csequence
      RAISING
        /apmg/cx_error.

    METHODS to_date
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE d
      RAISING
        /apmg/cx_error.

    METHODS to_time
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE t
      RAISING
        /apmg/cx_error ##NEEDED.

    METHODS to_timestamp
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE timestamp
      RAISING
        /apmg/cx_error.

    METHODS to_timestampl
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE timestampl
      RAISING
        /apmg/cx_error.

    METHODS to_utclong
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE utclong
      RAISING
        /apmg/cx_error.

    METHODS to_epoch
      IMPORTING
        !millisec     TYPE i OPTIONAL
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE string
      RAISING
        /apmg/cx_error ##NEEDED.

    METHODS to_unixtime
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE string
      RAISING
        /apmg/cx_error.

    METHODS to_isotime
      IMPORTING
        !timezone     TYPE string DEFAULT c_timezone-utc
      RETURNING
        VALUE(result) TYPE string
      RAISING
        /apmg/cx_error.

    METHODS to_string
      IMPORTING
        !encoding      TYPE string DEFAULT c_encoding-utf_8
        !ignore_errors TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result)  TYPE string
      RAISING
        /apmg/cx_error.

    METHODS to_hex
      CHANGING
        !result TYPE xsequence
      RAISING
        /apmg/cx_error.

    METHODS to_xstring
      IMPORTING
        !encoding      TYPE string DEFAULT c_encoding-utf_8
        !ignore_errors TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result)  TYPE xstring
      RAISING
        /apmg/cx_error.

    METHODS to_int
      RETURNING
        VALUE(result) TYPE i
      RAISING
        /apmg/cx_error.

    METHODS to_int8
      RETURNING
        VALUE(result) TYPE int8
      RAISING
        /apmg/cx_error.

    METHODS to_packed
      CHANGING
        !result TYPE p
      RAISING
        /apmg/cx_error.

    METHODS to_float
      RETURNING
        VALUE(result) TYPE f
      RAISING
        /apmg/cx_error.

    METHODS to_decfloat16
      RETURNING
        VALUE(result) TYPE decfloat16
      RAISING
        /apmg/cx_error.

    METHODS to_decfloat34
      RETURNING
        VALUE(result) TYPE decfloat34
      RAISING
        /apmg/cx_error.

    METHODS to_bool
      RETURNING
        VALUE(result) TYPE abap_bool
      RAISING
        /apmg/cx_error.

    METHODS to_typekind
      RETURNING
        VALUE(result) TYPE abap_typekind.

    METHODS to_typetext
      IMPORTING
        !is_long      TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA data_ref TYPE REF TO data.
    DATA typekind TYPE abap_typekind.
    DATA options TYPE ty_options.

    METHODS _conversion_error
      IMPORTING
        datatype      TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.



CLASS /apmg/cl_convert IMPLEMENTATION.


  METHOD constructor.

    me->options = options.
    from( data ).

  ENDMETHOD.


  METHOD create.

    result = NEW #(
      data    = data
      options = options ).

  ENDMETHOD.


  METHOD from.

    GET REFERENCE OF data INTO data_ref.
    typekind = cl_abap_typedescr=>describe_by_data( data )->type_kind.

    result = me.

  ENDMETHOD.


  METHOD to_bool.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_char.

        result = xsdbool( <data> = abap_true ).

      WHEN cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_struct2
        OR cl_abap_typedescr=>typekind_table
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        " TODO: Does this make sense?
        result = xsdbool( <data> IS NOT INITIAL ).

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'bool' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_char.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(string_data) = to_string( ).
            result = string_data.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'char' ).
        ENDTRY.

        IF condense( result ) <> condense( string_data ).
          RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'char' ).
        ENDIF.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'char' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_date.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string.

        TRY.
            result = CONV d( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'date' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_packed.

        TRY.
            CONVERT TIME STAMP <data> TIME ZONE timezone INTO DATE result.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'date' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'date' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_decfloat16.

    TRY.
        DATA(decfloat34) = to_decfloat34( ).
        result = CONV decfloat16( decfloat34 ).
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'decfloat16' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_decfloat34.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed.

        TRY.
            result = CONV decfloat34( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'decfloat34' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(string_data) = to_string( ).
            result = CONV decfloat34( string_data ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'decfloat34' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'decfloat34' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_epoch.

    " Milliseconds for the days since January 1, 1970, 00:00:00 UTC
    " https://en.wikipedia.org/wiki/Epoch_(computing)

    TYPES ty_ms TYPE n LENGTH 3.

    IF millisec < 0 OR millisec > 999.
      " Milliseconds must be between 0 and 999
      RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'epoch' ).
    ENDIF.

    TRY.
        DATA(ms) = CONV ty_ms( millisec ).
        result = to_unixtime( ) && ms.
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'epoch' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_float.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed.

        TRY.
            result = CONV f( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'float' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(string_data) = to_string( ).
            result = CONV f( string_data ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'float' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'float' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_hex.

    TRY.
        DATA(xstring_data) = to_xstring( ).
        result = xstring_data.
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'hex' ).
    ENDTRY.

    IF result <> xstring_data.
      RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'hex' ).
    ENDIF.

  ENDMETHOD.


  METHOD to_int.

    TRY.
        DATA(int8) = to_int8( ).
        result = CONV i( int8 ).
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'integer' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_int8.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed
        OR cl_abap_typedescr=>typekind_time.

        TRY.
            result = CONV int8( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'int8' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(string_data) = to_string( ).
            result = CONV int8( string_data ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'int8' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'int8' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_isotime.

    " YYYY-MM-DDThh:mm:ssZ format
    " https://en.m.wikipedia.org/wiki/ISO_8601

    TRY.
        DATA(timestampl) = to_timestampl( timezone ).

        result = |{ timestampl TIMESTAMP = ISO }|.
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'isotime' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_packed.

    " TODO: Does this handle length and decimals?

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed.

        TRY.
            result = <data>.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'packed' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(string_data) = to_string( ).
            result = string_data.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'packed' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'packed' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_string.

    FIELD-SYMBOLS <table> TYPE INDEX TABLE.

    lcl_utils=>validate_encoding( encoding ).

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong.

        TRY.
            result = CONV string( <data> ).
            " FIXME? Might have a trailing space. Should we trim it?
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'string' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_xsequence
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            DATA(xstring_data) = to_xstring( encoding = '' ).

            DATA(class_name) = 'CL_BINARY_CONVERT'.
            IF ignore_errors = abap_true.
              class_name = class_name && '_IGN_CERR'.
            ENDIF.

            DATA(method_name) = |XSTRING_{ encoding }_TO_STRING| ##NEEDED. " abaplint #3543

            CALL METHOD (class_name)=>(method_name)
              EXPORTING
                iv_xstring = xstring_data
              RECEIVING
                rv_string  = result.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'string' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_table.

        TRY.
            ASSIGN data_ref->* TO <table>.

            " Only works for flat tables
            " TODO: Deep tables (should be local class)
            result = concat_lines_of(
              table = <table>
              sep   = cl_abap_char_utilities=>newline ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'string' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'string' ).
    ENDCASE.

    IF options-trim_strings = abap_true.
      result = condense( result ).
    ENDIF.

  ENDMETHOD.


  METHOD to_time.

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_time.

        TRY.
            result = CONV t( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'time' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'time' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_timestamp.

    TYPES ty_frac TYPE p LENGTH 10 DECIMALS 6.

    TRY.
        DATA(timestampl) = to_timestampl( timezone ).
        DATA(frac) = CONV ty_frac( frac( timestampl ) ).
        IF frac <> 0.
          RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestamp' ).
        ENDIF.
        result = timestampl ##TYPE.
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestamp' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_timestampl.

    lcl_utils=>validate_timezone( timezone ).

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_packed.

        TRY.
            result = CONV timestampl( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestampl' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_date.

        TRY.
            CONVERT DATE <data> INTO TIME STAMP result TIME ZONE timezone.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestampl' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_utclong.

        TRY.
            result = cl_abap_tstmp=>utclong2tstmp( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestampl' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'timestampl' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_typekind.

    result = typekind.

  ENDMETHOD.


  METHOD to_typetext.

    result = lcl_utils=>to_typetext(
      typekind = typekind
      is_long  = is_long ).

  ENDMETHOD.


  METHOD to_unixtime.

    " Number of non-leap seconds which have passed since 00:00:00 UTC on Thursday, 1 January 1970
    " https://en.wikipedia.org/wiki/Unix_time

    TRY.
        DATA(timestamp_long) = to_timestampl( timezone ).

        CONVERT TIME STAMP timestamp_long TIME ZONE timezone INTO DATE DATA(date) TIME DATA(time).

        " Timestamp for passed days until today in seconds
        DATA(days_i)          = CONV i( date - '19700101' ).
        DATA(days_timestamp)  = CONV timestampl( days_i * 60 * 60 * 24 ).

        " Timestamp for time at present day
        DATA(sec_i)           = CONV i( time ).
        DATA(secs_timestamp)  = CONV timestampl( sec_i ).

        DATA(unixtime) = CONV timestampl( days_timestamp + secs_timestamp ).

        result = condense( CONV string( unixtime ) ).
      CATCH cx_root.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'unixtime' ).
    ENDTRY.

  ENDMETHOD.


  METHOD to_utclong.

    DATA t TYPE t.

    lcl_utils=>validate_timezone( timezone ).

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_packed.

        TRY.
            result = CONV utclong( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'utclong' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_date.

        TRY.
            CONVERT DATE <data> TIME t TIME ZONE timezone INTO UTCLONG result.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'utclong' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'utclong' ).
    ENDCASE.

  ENDMETHOD.


  METHOD to_xstring.

    lcl_utils=>validate_encoding( encoding ).

    ASSIGN data_ref->* TO FIELD-SYMBOL(<data>).
    ASSERT sy-subrc = 0.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_xstring.

        IF encoding IS NOT INITIAL.
          " Cannot convert encoding since data is already in hex format
          RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'xstring' ).
        ENDIF.

        TRY.
            result = CONV xstring( <data> ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'xstring' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string
        OR cl_abap_typedescr=>typekind_date
        OR cl_abap_typedescr=>typekind_decfloat16
        OR cl_abap_typedescr=>typekind_decfloat34
        OR cl_abap_typedescr=>typekind_float
        OR cl_abap_typedescr=>typekind_int
        OR cl_abap_typedescr=>typekind_int1
        OR cl_abap_typedescr=>typekind_int2
        OR cl_abap_typedescr=>typekind_int8
        OR cl_abap_typedescr=>typekind_num
        OR cl_abap_typedescr=>typekind_packed
        OR cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_table
        OR cl_abap_typedescr=>typekind_time
        OR cl_abap_typedescr=>typekind_utclong.

        TRY.
            DATA(string_data) = to_string( encoding = '' ).

            DATA(class_name) = 'CL_BINARY_CONVERT'.
            IF ignore_errors = abap_true.
              class_name = class_name && '_IGN_CERR'.
            ENDIF.

            DATA(method_name) = |STRING_TO_XSTRING_{ encoding }| ##NEEDED. " abaplint #3543

            CALL METHOD (class_name)=>(method_name)
              EXPORTING
                iv_string  = string_data
              RECEIVING
                rv_xstring = result.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'xstring' ).
        ENDTRY.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'xstring' ).
    ENDCASE.

  ENDMETHOD.


  METHOD _conversion_error.

    result = |Unable to convert { to_typetext( ) } to { datatype }|.

  ENDMETHOD.
ENDCLASS.
