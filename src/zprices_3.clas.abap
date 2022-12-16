CLASS zprices_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    METHODS calculate_lift_pass_price IMPORTING age         TYPE int4 OPTIONAL
                                                type        TYPE char10
                                      RETURNING VALUE(cost) TYPE int4.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPRICES_3 IMPLEMENTATION.


  METHOD calculate_lift_pass_price.
    FIELD-SYMBOLS: <liftname> TYPE char30.
    DATA: lt_liftnames TYPE TABLE OF char30,
          ls_liftnames LIKE LINE OF lt_liftnames.
    DATA: low_tax TYPE f VALUE '0.16'.
    DATA: cost_with_decimals TYPE f.
    DATA: high_tax TYPE f VALUE '0.07'.
    DATA: vip TYPE abap_bool.

    IF age IS SUPPLIED AND age < 6.
      cost = 0.
    ELSE.
      SELECT SINGLE cost FROM zbase_prices WHERE type = @type INTO @DATA(baseprice).
      IF type <> 'night'.
        SELECT * FROM zholidays INTO TABLE @DATA(holidays).

        DATA: isholiday TYPE abap_bool.
        DATA: reduction TYPE int4 VALUE 0.
        FIELD-SYMBOLS: <holidays_line> TYPE zholidays.

        DATA(date) = sy-datum.

        LOOP AT holidays ASSIGNING <holidays_line>.
          IF date IS NOT INITIAL.
            IF date(4) = <holidays_line>-holiday(4) AND
               date+4(2) = <holidays_line>-holiday+4(2) AND
               date+6(2) = <holidays_line>-holiday+6(2).
              isholiday = 'X'.
            ENDIF.
          ENDIF.
        ENDLOOP.

        DATA: day_p TYPE p.
        day_p = date MOD 7.
        IF day_p > 1.
          day_p = day_p - 1.
        ELSE.
          day_p = day_p + 6.
        ENDIF.

        IF isholiday = '' AND day_p = '1'.
          reduction = 35.
        ENDIF.
* TODO apply reduction for others
        IF age < 15.
          cost_with_decimals = baseprice * '0.7'.
          cost = ceil( cost_with_decimals ).
        ELSE.
          IF age IS NOT SUPPLIED.
            cost_with_decimals = baseprice * ( 1 - reduction / 100  ) .
            cost = ceil( cost_with_decimals ).
          ELSE.
            IF age > 64.
              cost_with_decimals = baseprice * '0.75' * ( 1 - reduction / 100  ) .
              cost = ceil( cost_with_decimals ).
            ELSE.
              cost_with_decimals = baseprice * ( 1 - reduction / 100  ) .
              cost = ceil( cost_with_decimals ).
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF age IS SUPPLIED AND age >= 6.
          IF age > 64.
            cost_with_decimals = baseprice * '0.4'.
            cost = ceil( cost_with_decimals ).
          ELSE.
            cost = ceil( baseprice ).
          ENDIF.
        ELSE.
          cost = 0.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
