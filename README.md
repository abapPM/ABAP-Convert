![Version](https://img.shields.io/endpoint?url=https://shield.abappm.com/github/abapPM/ABAP-Convert/src/zcl_convert.clas.abap/c_version&label=Version&color=blue)

[![License](https://img.shields.io/github/license/abapPM/ABAP-Convert?label=License&color=success)](https://github.com/abapPM/ABAP-Convert/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?color=success)](https://github.com/abapPM/.github/blob/main/CODE_OF_CONDUCT.md)
[![REUSE Status](https://api.reuse.software/badge/github.com/abapPM/ABAP-Convert)](https://api.reuse.software/info/github.com/abapPM/ABAP-Convert)

# Convert Any Data Type

The last class you will need to convert between data types. Well, that's the goal 😁

Do you remember how to convert a string to an xstring? How about an ABAP timestamp to Unixtime? Or a string to a CHAR with overflow check? Don't recall the syntax for the right string template to convert a timestamp to an ISO date? 🤔

Look no further and use this class 😄

NO WARRANTIES, [MIT License](https://github.com/abapPM/ABAP-Convert/blob/main/LICENSE)

> [!NOTE]
> It might make sense to move various date/time conversions into a separate "Temporal" object like in [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal). Open an issue to discuss if you're interested!

## Usage

Create an instance with the source value and use one of the methods to get the target value.

```abap
DATA(str) = NEW zcl_convert( value )->to_string( ).
" or
DATA(str) = NEW zcl_convert( )->from( value )->to_string( ).
" or
DATA(str) = zcl_convert=>create( value )->to_string( ).
```

Method | Description
-------|------------
`to_char`           | Changing result to type `c` with given length (with length check)
`to_bool`           | `value = abap_true` for type `c`, `value IS NOT INITIAL` for other types
`to_date` `^`       | Convert to type `d`
`to_decfloat16`     | Convert to type `decfloat16`
`to_decfloat34`     | Convert to type `decfloat34`
`to_epoch` `^`      | Milliseconds for the days since `January 1, 1970, 00:00:00 UTC` (see [Wikipedia](https://en.wikipedia.org/wiki/Epoch_(computing)))
`to_float`          | Convert to type `f`
`to_hex`            | Changing result to type `x` with given length (with length check)
`to_int`            | Convert to type `i`
`to_int8`           | Convert to type `int8`
`to_isotime` `^`    | Convert to `YYYY-MM-DDThh:mm:ssZ` format (see [Wikipedia](https://en.m.wikipedia.org/wiki/ISO_8601))
`to_packed`         | Changing result to type `p` with given length and decimal places
`to_string` `*`     | Convert to type `string`
`to_time` `^`       | Convert to type `t`
`to_timestamp` `^`  | Convert to type `timestamp`
`to_timestampl` `^` | Convert to type `timestampl`
`to_typekind `      | Get internal ABAP type (see `CL_ABAP_TYPEDESCR` for values)
`to_typetext `      | Get description of ABAP type
`to_unixtime ` `^`  | Number of non-leap seconds since `January 1, 1970, 00:00:00 UTC` (see [Wikipedia](https://en.wikipedia.org/wiki/Unix_time))
`to_utclong ` `^`   | Convert to type `utclong`
`to_xstring` `*`    | Convert to type `xstring`

`^` All date/time conversions include `timezone` as an optional parameter (default `UTC`).

`*` String and xstring conversions include `encodinng` (default `UTF8`) and `ignore_errors` as optional parameters.

Constructor options:

Option | Description
-------|------------
`trim_strings` | Remove trailing spaces when convertin to string (including intermediate conversions)

## Prerequisites

SAP Basis 7.50 or higher

## Installation

Install `convert` as a global module in your system using [apm](https://abappm.com).

or

Specify the `convert` module as a dependency in your project and import it to your namespace using [apm](https://abappm.com).

## Contributions

All contributions are welcome! Read our [Contribution Guidelines](https://github.com/abapPM/ABAP-Convert/blob/main/CONTRIBUTING.md), fork this repo, and create a pull request.

You can install the developer version of ABAP CONVERT using [abapGit](https://github.com/abapGit/abapGit) either by creating a new online repository for `https://github.com/abapPM/ABAP-Convert`.

Recommended SAP package: `$CONVERT`

## About

Made with ❤ in Canada

Copyright 2025 apm.to Inc. <https://apm.to>

Follow [@marcf.be](https://bsky.app/profile/marcf.be) on Blueksy and [@marcfbe](https://linkedin.com/in/marcfbe) or LinkedIn
