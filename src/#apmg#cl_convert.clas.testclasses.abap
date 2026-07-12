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

* FUTURE
*    CONSTANTS:
*      BEGIN OF c_regex,
*        utc_iso     TYPE string VALUE '^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z$',
*        utc_default TYPE string VALUE '^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})\.(\d{7})$',
*      END OF c_regex

    DATA:
      i              TYPE REF TO /apmg/cl_convert,
      i8             TYPE REF TO /apmg/cl_convert,
      f              TYPE REF TO /apmg/cl_convert,
      d16            TYPE REF TO /apmg/cl_convert,
      d34            TYPE REF TO /apmg/cl_convert,
      p              TYPE REF TO /apmg/cl_convert,
      c              TYPE REF TO /apmg/cl_convert,
      c_number       TYPE REF TO /apmg/cl_convert,
      n              TYPE REF TO /apmg/cl_convert,
      str            TYPE REF TO /apmg/cl_convert,
      str_number     TYPE REF TO /apmg/cl_convert,
      str_float      TYPE REF TO /apmg/cl_convert,
      str_date       TYPE REF TO /apmg/cl_convert,
      str_time       TYPE REF TO /apmg/cl_convert,
      str_timestamp  TYPE REF TO /apmg/cl_convert,
      str_timestampl TYPE REF TO /apmg/cl_convert,
      d              TYPE REF TO /apmg/cl_convert,
      t              TYPE REF TO /apmg/cl_convert,
      x              TYPE REF TO /apmg/cl_convert,
      xstr           TYPE REF TO /apmg/cl_convert,
      timestamp      TYPE REF TO /apmg/cl_convert,
      timestampl     TYPE REF TO /apmg/cl_convert,
      utclong        TYPE REF TO /apmg/cl_convert.

    METHODS:
      setup,
      to_char FOR TESTING RAISING /apmg/cx_error,
      to_bool FOR TESTING RAISING /apmg/cx_error,
      to_date FOR TESTING RAISING /apmg/cx_error,
      to_decfloat16 FOR TESTING RAISING /apmg/cx_error,
      to_decfloat34 FOR TESTING RAISING /apmg/cx_error,
      to_epoch FOR TESTING RAISING /apmg/cx_error,
      to_float FOR TESTING RAISING /apmg/cx_error,
      to_hex FOR TESTING RAISING /apmg/cx_error,
      to_int FOR TESTING RAISING /apmg/cx_error,
      to_int8 FOR TESTING RAISING /apmg/cx_error,
      to_isotime FOR TESTING RAISING /apmg/cx_error,
      to_packed FOR TESTING RAISING /apmg/cx_error,
      to_string FOR TESTING RAISING /apmg/cx_error,
      to_time FOR TESTING RAISING /apmg/cx_error,
      to_timestamp FOR TESTING RAISING /apmg/cx_error,
      to_timestampl FOR TESTING RAISING /apmg/cx_error,
      to_typekind FOR TESTING RAISING /apmg/cx_error,
      to_typetext FOR TESTING RAISING /apmg/cx_error,
      to_unixtime FOR TESTING RAISING /apmg/cx_error,
      to_utclong FOR TESTING RAISING /apmg/cx_error,
      to_xstring FOR TESTING RAISING /apmg/cx_error.

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
        i8->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        f->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        d16->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        d34->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = p->to_int( )
      exp = 123457 ).

    TRY.
        c->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = c_number->to_int( )
      exp = 12345678 ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_int( )
      exp = 14 ).

    TRY.
        str->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
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
        xstr->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        timestamp->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        timestampl->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        utclong->to_int( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
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

    DATA empty TYPE string.

    cl_abap_unit_assert=>assert_false( c->to_bool( ) ).
    cl_abap_unit_assert=>assert_false( /apmg/cl_convert=>create( empty )->to_bool( ) ).

    cl_abap_unit_assert=>assert_true( i->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( i8->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( f->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( d16->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( d34->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( p->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( n->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( str->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( d->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( t->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( x->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( xstr->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( timestamp->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( timestampl->to_bool( ) ).
    cl_abap_unit_assert=>assert_true( utclong->to_bool( ) ).

  ENDMETHOD.

  METHOD to_date.

    cl_abap_unit_assert=>assert_equals(
      act = d->to_date( )
      exp = c_test-d ).

    cl_abap_unit_assert=>assert_equals(
      act = str_date->to_date( )
      exp = c_test-d ).

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_date( )
      exp = '20010203' ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_date( )
      exp = '20010203' ).

    TRY.
        i->to_date( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_decfloat16.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_decfloat16( )
      exp = CONV decfloat16( c_test-i ) ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_decfloat16( )
      exp = CONV decfloat16( c_test-i8 ) ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_decfloat16( )
      exp = CONV decfloat16( c_test-f ) ).

    cl_abap_unit_assert=>assert_equals(
      act = d16->to_decfloat16( )
      exp = c_test-d16 ).

    TRY.
        d34->to_decfloat16( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = p->to_decfloat16( )
      exp = CONV decfloat16( c_test-p ) ).

    cl_abap_unit_assert=>assert_equals(
      act = c_number->to_decfloat16( )
      exp = CONV decfloat16( c_test-c_number ) ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_decfloat16( )
      exp = CONV decfloat16( c_test-n ) ).

    cl_abap_unit_assert=>assert_equals(
      act = str_number->to_decfloat16( )
      exp = CONV decfloat16( c_test-str_number ) ).

    TRY.
        str->to_decfloat16( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_decfloat34.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_decfloat34( )
      exp = CONV decfloat34( c_test-i ) ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_decfloat34( )
      exp = CONV decfloat34( c_test-i8 ) ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_decfloat34( )
      exp = CONV decfloat34( c_test-f ) ).

    cl_abap_unit_assert=>assert_equals(
      act = d16->to_decfloat34( )
      exp = CONV decfloat34( c_test-d16 ) ).

    cl_abap_unit_assert=>assert_equals(
      act = d34->to_decfloat34( )
      exp = c_test-d34 ).

    cl_abap_unit_assert=>assert_equals(
      act = p->to_decfloat34( )
      exp = CONV decfloat34( c_test-p ) ).

    cl_abap_unit_assert=>assert_equals(
      act = str_float->to_decfloat34( )
      exp = CONV decfloat34( c_test-str_float ) ).

    TRY.
        str->to_decfloat34( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_epoch.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_epoch( )
      exp = `981203696000` ).

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_epoch( millisec = 123 )
      exp = `981203696123` ).

    TRY.
        timestamp->to_epoch( millisec = -1 ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        timestamp->to_epoch( millisec = 1000 ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_float.

    DATA exp TYPE f.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_float( )
      exp = CONV f( c_test-i ) ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_float( )
      exp = CONV f( c_test-i8 ) ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_float( )
      exp = c_test-f ).

    TRY.
        d16->to_float( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        d34->to_float( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = p->to_float( )
      exp = CONV f( c_test-p ) ).

    exp = c_test-str_float.
    cl_abap_unit_assert=>assert_equals(
      act = str_float->to_float( )
      exp = exp ).

    TRY.
        str->to_float( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_hex.

    DATA act TYPE x LENGTH 7.

    str->to_hex( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = '6D617263666265' ).

    xstr->to_hex( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = c_test-xstr ).

    TRY.
        x->to_hex( CHANGING result = act ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_int8.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_int8( )
      exp = CONV int8( c_test-i ) ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_int8( )
      exp = c_test-i8 ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_int8( )
      exp = CONV int8( '12340000000' ) ).

    TRY.
        d16->to_int8( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    TRY.
        d34->to_int8( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = p->to_int8( )
      exp = 123457 ).

    cl_abap_unit_assert=>assert_equals(
      act = c_number->to_int8( )
      exp = 12345678 ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_int8( )
      exp = 14 ).

    TRY.
        str->to_int8( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = str_number->to_int8( )
      exp = 123456789 ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_int8( )
      exp = 738486 ).

    cl_abap_unit_assert=>assert_equals(
      act = t->to_int8( )
      exp = 45296 ).

    cl_abap_unit_assert=>assert_equals(
      act = x->to_int8( )
      exp = 1298231907 ).

    TRY.
        xstr->to_int8( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_isotime.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_isotime( )
      exp = `2001-02-03T12:34:56` ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_isotime( )
      exp = `2001-02-03T12:34:56.7890000` ).

    TRY.
        str->to_isotime( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_packed.

    DATA act TYPE p LENGTH 16 DECIMALS 10.
    DATA exp TYPE p LENGTH 16 DECIMALS 10.

    i->to_packed( CHANGING result = act ).
    exp = c_test-i.
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = exp ).

    i8->to_packed( CHANGING result = act ).
    exp = c_test-i8.
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = exp ).

    f->to_packed( CHANGING result = act ).
    exp = c_test-f.
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = exp ).

    p->to_packed( CHANGING result = act ).
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = c_test-p ).

    c_number->to_packed( CHANGING result = act ).
    exp = c_test-c_number.
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = exp ).

    str_number->to_packed( CHANGING result = act ).
    exp = c_test-str_number.
    cl_abap_unit_assert=>assert_equals(
      act = act
      exp = exp ).

    TRY.
        str->to_packed( CHANGING result = act ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_time.

    cl_abap_unit_assert=>assert_equals(
      act = t->to_time( )
      exp = c_test-t ).

    cl_abap_unit_assert=>assert_equals(
      act = str_time->to_time( )
      exp = c_test-t ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_time( )
      exp = '000014' ).

    TRY.
        i->to_time( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_timestamp.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_timestamp( )
      exp = c_test-timestamp ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_timestamp( )
      exp = '20221126000000' ).

    TRY.
        timestampl->to_timestamp( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_timestampl.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_timestampl( )
      exp = CONV timestampl( c_test-timestamp ) ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_timestampl( )
      exp = c_test-timestampl ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_timestampl( )
      exp = CONV timestampl( '20221126000000' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = utclong->to_timestampl( )
      exp = CONV timestampl( '19720601123456.7890120' ) ).

    TRY.
        str_timestamp->to_timestampl( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_typekind.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_typekind( )
      exp = cl_abap_typedescr=>typekind_int ).

    cl_abap_unit_assert=>assert_equals(
      act = i8->to_typekind( )
      exp = cl_abap_typedescr=>typekind_int8 ).

    cl_abap_unit_assert=>assert_equals(
      act = f->to_typekind( )
      exp = cl_abap_typedescr=>typekind_float ).

    cl_abap_unit_assert=>assert_equals(
      act = d16->to_typekind( )
      exp = cl_abap_typedescr=>typekind_decfloat16 ).

    cl_abap_unit_assert=>assert_equals(
      act = d34->to_typekind( )
      exp = cl_abap_typedescr=>typekind_decfloat34 ).

    cl_abap_unit_assert=>assert_equals(
      act = p->to_typekind( )
      exp = cl_abap_typedescr=>typekind_packed ).

    cl_abap_unit_assert=>assert_equals(
      act = c->to_typekind( )
      exp = cl_abap_typedescr=>typekind_char ).

    cl_abap_unit_assert=>assert_equals(
      act = n->to_typekind( )
      exp = cl_abap_typedescr=>typekind_num ).

    cl_abap_unit_assert=>assert_equals(
      act = str->to_typekind( )
      exp = cl_abap_typedescr=>typekind_string ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_typekind( )
      exp = cl_abap_typedescr=>typekind_date ).

    cl_abap_unit_assert=>assert_equals(
      act = t->to_typekind( )
      exp = cl_abap_typedescr=>typekind_time ).

    cl_abap_unit_assert=>assert_equals(
      act = x->to_typekind( )
      exp = cl_abap_typedescr=>typekind_hex ).

    cl_abap_unit_assert=>assert_equals(
      act = xstr->to_typekind( )
      exp = cl_abap_typedescr=>typekind_xstring ).

  ENDMETHOD.

  METHOD to_typetext.

    cl_abap_unit_assert=>assert_equals(
      act = i->to_typetext( )
      exp = `integer` ).

    cl_abap_unit_assert=>assert_equals(
      act = i->to_typetext( abap_true )
      exp = `4-byte integer` ).

    cl_abap_unit_assert=>assert_equals(
      act = c->to_typetext( )
      exp = `character` ).

    cl_abap_unit_assert=>assert_equals(
      act = c->to_typetext( abap_true )
      exp = `text field` ).

    cl_abap_unit_assert=>assert_equals(
      act = str->to_typetext( )
      exp = `string` ).

    cl_abap_unit_assert=>assert_equals(
      act = str->to_typetext( abap_true )
      exp = `text string` ).

    cl_abap_unit_assert=>assert_equals(
      act = xstr->to_typetext( )
      exp = `xstring` ).

    cl_abap_unit_assert=>assert_equals(
      act = utclong->to_typetext( )
      exp = `timestamp` ).

  ENDMETHOD.

  METHOD to_unixtime.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_unixtime( )
      exp = `981203696` ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_unixtime( )
      exp = `981203696` ).

    cl_abap_unit_assert=>assert_equals(
      act = utclong->to_unixtime( )
      exp = `76250096` ).

    TRY.
        str_timestamp->to_unixtime( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_utclong.

    cl_abap_unit_assert=>assert_equals(
      act = timestamp->to_utclong( )
      exp = CONV utclong( c_test-timestamp ) ).

    cl_abap_unit_assert=>assert_equals(
      act = timestampl->to_utclong( )
      exp = CONV utclong( c_test-timestampl ) ).

    cl_abap_unit_assert=>assert_equals(
      act = d->to_utclong( )
      exp = CONV utclong( `2022-11-26 00:00:00.0000000` ) ).

    TRY.
        str_timestamp->to_utclong( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.

  METHOD to_xstring.

    cl_abap_unit_assert=>assert_equals(
      act = str->to_xstring( )
      exp = CONV xstring( '6D617263666265' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = x->to_xstring( encoding = '' )
      exp = c_test-x ).

    cl_abap_unit_assert=>assert_equals(
      act = xstr->to_xstring( encoding = '' )
      exp = c_test-xstr ).

    TRY.
        x->to_xstring( ).
        cl_abap_unit_assert=>fail( ).
      CATCH /apmg/cx_error.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
