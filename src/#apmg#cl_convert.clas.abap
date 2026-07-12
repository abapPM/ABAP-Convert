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
      BEGIN OF c_timezone,
        afghanistan                         TYPE string VALUE 'AFGHAN',
        alaska_aleutian                     TYPE string VALUE 'ALAW',
        alaska_anchorage                    TYPE string VALUE 'ALA',
        argentina                           TYPE string VALUE 'ART',
        atlantic_time_halifax               TYPE string VALUE 'AST',
        australia_eucla                     TYPE string VALUE 'AUSEUC',
        australia_lord_howe_island          TYPE string VALUE 'AUSLHI',
        australia_new_south_wales           TYPE string VALUE 'AUSNSW',
        australia_northern_territories      TYPE string VALUE 'AUSNT',
        australia_queensland                TYPE string VALUE 'AUSQLD',
        australia_south_australia           TYPE string VALUE 'AUSSA',
        australia_tasmania                  TYPE string VALUE 'AUSTAS',
        australia_victoria                  TYPE string VALUE 'AUSVIC',
        australia_western_australia         TYPE string VALUE 'AUSWA',
        azerbaijan                          TYPE string VALUE 'AZT',
        bangladesh                          TYPE string VALUE 'BDT',
        brazil                              TYPE string VALUE 'BRAZIL',
        brazil_andes                        TYPE string VALUE 'BRZLAN',
        brazil_west                         TYPE string VALUE 'BRZLWE',
        central_africa                      TYPE string VALUE 'CAT',
        central_europe                      TYPE string VALUE 'CET',
        central_time_dallas                 TYPE string VALUE 'CST',
        central_time_no_dst                 TYPE string VALUE 'CSTNO',
        central_time_north_america          TYPE string VALUE 'CST_NA',
        chile                               TYPE string VALUE 'CHILE',
        chile_easter_island                 TYPE string VALUE 'CHILEE',
        chile_magallanes                    TYPE string VALUE 'CHILEM',
        cyprus                              TYPE string VALUE 'CYPRUS',
        eastern_europe                      TYPE string VALUE 'EET',
        eastern_greenland                   TYPE string VALUE 'GSTE',
        eastern_time_new_york               TYPE string VALUE 'EST',
        eastern_time_north_america          TYPE string VALUE 'EST_NA',
        egypt                               TYPE string VALUE 'EGYPT',
        est_without_dst                     TYPE string VALUE 'ESTNO',
        europe_azores                       TYPE string VALUE 'AZOREN',
        falkland_islands                    TYPE string VALUE 'FLKLND',
        greenland                           TYPE string VALUE 'GST',
        greenwich_uk_with_dst               TYPE string VALUE 'GMTUK',
        hawaii                              TYPE string VALUE 'HAW',
        india                               TYPE string VALUE 'INDIA',
        iran                                TYPE string VALUE 'IRAN',
        iraq                                TYPE string VALUE 'IRAQ',
        israel                              TYPE string VALUE 'ISRAEL',
        japan                               TYPE string VALUE 'JAPAN',
        jordan                              TYPE string VALUE 'JORDAN',
        lebanon                             TYPE string VALUE 'LBANON',
        mauritius                           TYPE string VALUE 'MAU',
        morocco                             TYPE string VALUE 'MOROCC',
        mountain_time_denver                TYPE string VALUE 'MST',
        mountain_time_north_america         TYPE string VALUE 'MST_NA',
        mountain_time_phoenix               TYPE string VALUE 'MSTNO',
        nepal                               TYPE string VALUE 'NEPAL',
        new_zealand                         TYPE string VALUE 'NZST',
        new_zealand_chatham_islands         TYPE string VALUE 'NZCHA',
        newfoundland                        TYPE string VALUE 'NST',
        norfolk_islands                     TYPE string VALUE 'NORFLK',
        pacific_time_los_angeles            TYPE string VALUE 'PST',
        pakistan                            TYPE string VALUE 'PKT',
        paraguay                            TYPE string VALUE 'PARAGY',
        republic_of_fiji                    TYPE string VALUE 'FIJI',
        republic_of_moldova                 TYPE string VALUE 'MOLDVA',
        russia_msk                          TYPE string VALUE 'RUS03',
        russia_msk_minus_01                 TYPE string VALUE 'RUS02',
        russia_msk_plus_01                  TYPE string VALUE 'RUS04',
        russia_msk_plus_02                  TYPE string VALUE 'RUS05',
        russia_msk_plus_03                  TYPE string VALUE 'RUS06',
        russia_msk_plus_04                  TYPE string VALUE 'RUS07',
        russia_msk_plus_05                  TYPE string VALUE 'RUS08',
        russia_msk_plus_06                  TYPE string VALUE 'RUS09',
        russia_msk_plus_07                  TYPE string VALUE 'RUS10',
        russia_msk_plus_08                  TYPE string VALUE 'RUS11',
        russia_msk_plus_09                  TYPE string VALUE 'RUS12',
        saint_minus_pierre_miquelon         TYPE string VALUE 'PIERRE',
        syria                               TYPE string VALUE 'SYRIA',
        turkey                              TYPE string VALUE 'TURKEY',
        uruguay                             TYPE string VALUE 'URUGUA',
        utc                                 TYPE string VALUE 'UTC',
        utc_minus_01                        TYPE string VALUE 'UTC-1',
        utc_minus_02                        TYPE string VALUE 'UTC-2',
        utc_minus_03                        TYPE string VALUE 'UTC-3',
        utc_minus_04                        TYPE string VALUE 'UTC-4',
        utc_minus_05                        TYPE string VALUE 'UTC-5',
        utc_minus_06                        TYPE string VALUE 'UTC-6',
        utc_minus_07                        TYPE string VALUE 'UTC-7',
        utc_minus_08                        TYPE string VALUE 'UTC-8',
        utc_minus_09                        TYPE string VALUE 'UTC-9',
        utc_minus_10                        TYPE string VALUE 'UTC-10',
        utc_minus_11                        TYPE string VALUE 'UTC-11',
        utc_minus_12                        TYPE string VALUE 'UTC-12',
        utc_minus_13                        TYPE string VALUE 'UTC-13',
        utc_minus_14                        TYPE string VALUE 'UTC-14',
        utc_plus_01                         TYPE string VALUE 'UTC+1',
        utc_plus_02                         TYPE string VALUE 'UTC+2',
        utc_plus_03                         TYPE string VALUE 'UTC+3',
        utc_plus_04                         TYPE string VALUE 'UTC+4',
        utc_plus_05                         TYPE string VALUE 'UTC+5',
        utc_plus_05_30                      TYPE string VALUE 'UTC+53',
        utc_plus_06                         TYPE string VALUE 'UTC+6',
        utc_plus_06_30                      TYPE string VALUE 'UTC+63',
        utc_plus_07                         TYPE string VALUE 'UTC+7',
        utc_plus_08                         TYPE string VALUE 'UTC+8',
        utc_plus_09                         TYPE string VALUE 'UTC+9',
        utc_plus_10                         TYPE string VALUE 'UTC+10',
        utc_plus_11                         TYPE string VALUE 'UTC+11',
        utc_plus_12                         TYPE string VALUE 'UTC+12',
        utc_plus_13                         TYPE string VALUE 'UTC+13',
        utc_plus_14                         TYPE string VALUE 'UTC+14',
        western_africa                      TYPE string VALUE 'WAT',
        western_europe                      TYPE string VALUE 'WET',
        western_greenland                   TYPE string VALUE 'GSTW',
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
      IMPORTING
        !encoding TYPE string DEFAULT c_encoding-utf_8
      CHANGING
        !result   TYPE xsequence
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
        OR cl_abap_typedescr=>typekind_num
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

      WHEN cl_abap_typedescr=>typekind_utclong.

        TRY.
            DATA(timestampl) = to_timestampl( timezone ).
            CONVERT TIME STAMP timestampl TIME ZONE timezone INTO DATE result.
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
        result = to_unixtime( timezone ) && ms.
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

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_hex
        OR cl_abap_typedescr=>typekind_xstring.

        TRY.
            " No encoding
            DATA(xstring_data) = to_xstring( encoding = '' ).
            result = xstring_data.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'hex' ).
        ENDTRY.


      WHEN cl_abap_typedescr=>typekind_char
        OR cl_abap_typedescr=>typekind_string.

        TRY.
            " With encoding
            xstring_data = to_xstring( encoding = encoding ).
            result = xstring_data.
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'hex' ).
        ENDTRY.
    ENDCASE.

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

    " yyyy-mm-ddThh:mm:ss,fffffff
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
        OR cl_abap_typedescr=>typekind_string.

        TRY.
            DATA(time_text) = to_string( ).
            result = CONV t( time_text ).
          CATCH cx_root.
            RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = _conversion_error( 'time' ).
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_time.

        TRY.
            result = <data>.
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
        DATA(epoch)          = CONV timestampl( '19700101000000' ).

        DATA(unixtime) = floor( cl_abap_tstmp=>subtract(
          tstmp1 = timestamp_long
          tstmp2 = epoch ) ).

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
            result = cl_abap_tstmp=>tstmp2utclong( <data> ).
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
