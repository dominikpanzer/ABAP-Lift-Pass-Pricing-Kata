CLASS zprices_prepare_database DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS delete_all_prices.
    METHODS delete_all_holidays.
    METHODS set_holidays.
    METHODS set_prices.
ENDCLASS.



CLASS ZPRICES_PREPARE_DATABASE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    delete_all_prices( ).
    set_prices( ).

    delete_all_holidays( ).
    set_holidays( ).
  ENDMETHOD.


  METHOD set_prices.

    TYPES prices TYPE TABLE OF zbase_prices WITH KEY type.
    DATA(new_prices) = VALUE prices( ( cost = 35 type = '1jour' )
    ( cost = 19 type = 'night' ) ).
    INSERT  zbase_prices FROM TABLE @new_prices.

  ENDMETHOD.


  METHOD set_holidays.

    TYPES holidays TYPE TABLE OF zholidays WITH KEY holiday.
    DATA(new_holidays) = VALUE holidays( ( holiday = '20190218' description = 'winter' )
                                         ( holiday = '20190225' description = 'winter' )
                                         ( holiday = '20190304' description = 'winter' ) ).
    INSERT zholidays FROM TABLE @new_holidays.

  ENDMETHOD.


  METHOD delete_all_holidays.

    DELETE FROM zholidays.

  ENDMETHOD.


  METHOD delete_all_prices.

    DELETE FROM zbase_prices.

  ENDMETHOD.
ENDCLASS.
