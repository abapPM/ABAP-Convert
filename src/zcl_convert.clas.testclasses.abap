CLASS ltcl_convert DEFINITION FOR TESTING RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_test,
        i              TYPE i VALUE 123456,
        i8             TYPE int8 VALUE 1234567890123456, " > int4
        f              TYPE f VALUE '1.234E10',
        d16            TYPE decfloat16 VALUE '1.234E380', " > float
        d34            TYPE decfloat34 VALUE '1.234E6000', " > decfloat16
        p              TYPE p LENGTH 16 DECIMALS 10 VALUE '123456.789',
        c              TYPE c LENGTH 3 VALUE 'abc',
        c_number       TYPE c LENGTH 10 VALUE '12345678',
        n              TYPE n LENGTH 5 VALUE '00014',
        str            TYPE string VALUE 'marcfbe',
        str_number     TYPE string VALUE '123456789',
        str_float      TYPE string VALUE '1234.5678E90',
        str_date       TYPE string VALUE '20221126',
        str_time       TYPE string VALUE '123456',
        str_timestamp  TYPE string VALUE '20010203123456',
        str_timestampl TYPE string VALUE '20010203123456.789',
        d              TYPE d VALUE '20221126',
        t              TYPE t VALUE '123456',
        x              TYPE x LENGTH 4 VALUE '4D617263',
        xstr           TYPE xstring VALUE '4265726E617264',
        timestamp      TYPE timestamp VALUE '20010203123456',
        timestampl     TYPE timestampl VALUE '20010203123456.789',
        utclong        TYPE utclong VALUE '1972-06-01T12:34:56.7890123',
      END OF c_test.

    CONSTANTS:
      BEGIN OF c_regex,
        utc_iso     TYPE string VALUE '^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z$',
        utc_default TYPE string VALUE '^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})\.(\d{7})$',
      END OF c_regex.

    DATA:
      i              TYPE REF TO zcl_convert,
      i8             TYPE REF TO zcl_convert,
      f              TYPE REF TO zcl_convert,
      d16            TYPE REF TO zcl_convert,
      d34            TYPE REF TO zcl_convert,
      p              TYPE REF TO zcl_convert,
      c              TYPE REF TO zcl_convert,
      c_number       TYPE REF TO zcl_convert,
      n              TYPE REF TO zcl_convert,
      str            TYPE REF TO zcl_convert,
      str_number     TYPE REF TO zcl_convert,
      str_float      TYPE REF TO zcl_convert,
      str_date       TYPE REF TO zcl_convert,
      str_time       TYPE REF TO zcl_convert,
      str_timestamp  TYPE REF TO zcl_convert,
      str_timestampl TYPE REF TO zcl_convert,
      d              TYPE REF TO zcl_convert,
      t              TYPE REF TO zcl_convert,
      x              TYPE REF TO zcl_convert,
      xstr           TYPE REF TO zcl_convert,
      timestamp      TYPE REF TO zcl_convert,
      timestampl     TYPE REF TO zcl_convert,
      utclong        TYPE REF TO zcl_convert.

    METHODS:
      setup,
      to_char FOR TESTING RAISING zcx_error,
      to_bool FOR TESTING RAISING zcx_error,
      to_date FOR TESTING RAISING zcx_error,
      to_decfloat16 FOR TESTING RAISING zcx_error,
      to_decfloat34 FOR TESTING RAISING zcx_error,
      to_epoch FOR TESTING RAISING zcx_error,
      to_float FOR TESTING RAISING zcx_error,
      to_hex FOR TESTING RAISING zcx_error,
      to_int FOR TESTING RAISING zcx_error,
      to_int8 FOR TESTING RAISING zcx_error,
      to_isotime FOR TESTING RAISING zcx_error,
      to_packed FOR TESTING RAISING zcx_error,
      to_string FOR TESTING RAISING zcx_error,
      to_time FOR TESTING RAISING zcx_error,
      to_timestamp FOR TESTING RAISING zcx_error,
      to_timestampl FOR TESTING RAISING zcx_error,
      to_typekind FOR TESTING RAISING zcx_error,
      to_typetext FOR TESTING RAISING zcx_error,
      to_unixtime FOR TESTING RAISING zcx_error,
      to_utclong FOR TESTING RAISING zcx_error,
      to_xstring FOR TESTING RAISING zcx_error.

ENDCLASS.

CLASS ltcl_convert IMPLEMENTATION.

  METHOD setup.
    i              = NEW #( c_test-i ).
    i8             = NEW #( c_test-i8 ).
    f              = NEW #( c_test-f ).
    d16            = NEW #( c_test-d16 ).
    d34            = NEW #( c_test-d34 ).
    p              = NEW #( c_test-p ).
    c              = NEW #( c_test-c ).
    c_number       = NEW #( c_test-c_number ).
    n              = NEW #( c_test-n ).
    str            = NEW #( c_test-str ).
    str_number     = NEW #( c_test-str_number ).
    str_float      = NEW #( c_test-str_float ).
    str_date       = NEW #( c_test-str_date ).
    str_time       = NEW #( c_test-str_time ).
    str_timestamp  = NEW #( c_test-str_timestamp ).
    str_timestampl = NEW #( c_test-str_timestampl ).
    d              = NEW #( c_test-d ).
    t              = NEW #( c_test-t ).
    x              = NEW #( c_test-x ).
    xstr           = NEW #( c_test-xstr ).
    timestamp      = NEW #( c_test-timestamp ).
    timestampl     = NEW #( c_test-timestampl ).
    utclong        = NEW #( c_test-utclong ).
    " Example with trimming result
    " i = NEW #( data = c_test-i options = VALUE #( trim_strings = abap_true ) )
  ENDMETHOD.

  METHOD to_int.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_int( )
      exp = c_test-i ).

    TRY.
        DATA(_i8) = i8->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_f) = f->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_d16) = d16->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_d34) = d34->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = p->to_int( )
      exp = 123457 ).

    TRY.
        DATA(_c) = c->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = c_number->to_int( )
      exp = 12345678 ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_int( )
      exp = 14 ).

    TRY.
        DATA(_str) = str->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = str_number->to_int( )
      exp = 123456789 ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_int( )
      exp = 738486 ).

    cl_abap_unit_assert=>assert_equals(
      act = t->to_int( )
      exp = 45296 ).

    cl_abap_unit_assert=>assert_equals(
      act = x->to_int( )
      exp = 1298231907 ).

    TRY.
        DATA(_xstr) = xstr->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_ts) = timestamp->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_tl) = timestampl->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

    TRY.
        DATA(_utc) = utclong->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_string.

    cl_abap_unit_assert=>assert_equals(
      act = str->to_string( )
      exp = c_test-str ).

    cl_abap_unit_assert=>assert_equals(
      act = i->to_string( )
      exp = `123456 ` ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_string( )
      exp = `1234567890123456 ` ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_string( )
      exp = `1.2340000000000000E+10` ).

    cl_abap_unit_assert=>assert_equals(
      act = d16->to_string( )
      exp = `1.23400000000E+380` ).

    cl_abap_unit_assert=>assert_equals(
      act = d34->to_string( )
      exp = `1.234E+6000` ).

    cl_abap_unit_assert=>assert_equals(
      act = p->to_string( )
      exp = `123456.7890000000 ` ).

    cl_abap_unit_assert=>assert_equals(
      act = c->to_string( )
      exp = `abc` ).

    cl_abap_unit_assert=>assert_equals(
      act = c_number->to_string( )
      exp = `12345678` ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_string( )
      exp = `00014` ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_string( )
      exp = `20221126` ).

    cl_abap_unit_assert=>assert_equals(
      act = t->to_string( )
      exp = `123456` ).

    cl_abap_unit_assert=>assert_equals(
      act = x->to_string( )
      exp = `Marc` ).

    cl_abap_unit_assert=>assert_equals(
      act = xstr->to_string( )
      exp = `Bernard` ).

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_string( )
      exp = `20010203123456 ` ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_string( )
      exp = `20010203123456.7890000 ` ).

    cl_abap_unit_assert=>assert_equals(
      act = utclong->to_string( )
      exp = `1972-06-01 12:34:56.7890123` ).

  ENDMETHOD.

  METHOD to_char.

    DATA act TYPE c LENGTH 30.

    c->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = c_test-c ).

    i->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '123456 ' ).

    i8->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '1234567890123456 ' ).

    f->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '1.2340000000000000E+10' ).

    d16->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '1.23400000000E+380' ).

    d34->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '1.234E+6000' ).

    p->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '123456.7890000000 ' ).

    c_number->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '12345678' ).

    n->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '00014' ).

    str->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = 'marcfbe' ).

    d->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '20221126' ).

    t->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '123456' ).

    x->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = 'Marc' ).

    xstr->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = 'Bernard' ).

    timestamp->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '20010203123456 ' ).

    timestampl->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '20010203123456.7890000 ' ).

    utclong->to_char( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '1972-06-01 12:34:56.7890123' ).

  ENDMETHOD.

  METHOD to_bool.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_date.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_decfloat16.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_decfloat34.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_epoch.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_float.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_hex.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_int8.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_isotime.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_packed.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_time.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_timestamp.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_timestampl.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_typekind.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_typetext.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_unixtime.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_utclong.
    ASSERT 0 = 0.
  ENDMETHOD.

  METHOD to_xstring.
    ASSERT 0 = 0.
  ENDMETHOD.
ENDCLASS.
