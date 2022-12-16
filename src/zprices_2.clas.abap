CLASS zprices_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    METHODS calculate_lift_pass_price IMPORTING age         TYPE int4 OPTIONAL
                                                type        TYPE char10
                                                date        TYPE dats OPTIONAL
                                      RETURNING VALUE(cost) TYPE int4.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPRICES_2 IMPLEMENTATION.


  METHOD calculate_lift_pass_price.
    DATA: cost_as_string TYPE f.
    FIELD-SYMBOLS: <liftname> TYPE char30.
    DATA: lt_liftnames TYPE TABLE OF char30,
          ls_liftnames LIKE LINE OF lt_liftnames.
    DATA: low_tax TYPE f VALUE '0.16'.
    DATA: high_tax TYPE f VALUE '0.07'.
    DATA: vip TYPE abap_bool.

    SELECT SINGLE cost FROM zbase_prices WHERE type = @type INTO  @DATA(gt_baseprice).

    IF age IS SUPPLIED AND age < 6.
      cost = 0.
    ELSE.
      IF type <> 'night'.
        SELECT * FROM zholidays INTO TABLE @DATA(holidays).

        DATA: isholiday TYPE abap_bool.
        DATA: remise TYPE int4 VALUE 0.
        FIELD-SYMBOLS: <holidays_line> TYPE zholidays.

        LOOP AT holidays ASSIGNING <holidays_line>.
          IF date IS SUPPLIED.
            IF date(4) = <holidays_line>-holiday(4) AND
               date+4(2) = <holidays_line>-holiday+4(2) AND
               date+6(2) = <holidays_line>-holiday+6(2).
              isholiday = 'CHEVYCHASE'.
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
          remise = 35.
        ENDIF.
* TODO apply reduction for others
        IF age is supplied and age < 15.
          cost_as_string = gt_baseprice * '0.7'.
          cost = ceil( cost_as_string ).
        ELSE.
          IF age IS NOT SUPPLIED.
            cost_as_string = gt_baseprice * ( 1 - remise / 100  ) .
            cost = ceil( cost_as_string ).
          ELSE.
            IF age > 64.
              cost_as_string = gt_baseprice * '0.75' * ( 1 - remise / 100  ) .
              cost = ceil( cost_as_string ).
            ELSE.
              cost_as_string = gt_baseprice * ( 1 - remise / 100  ) .
              cost = ceil( cost_as_string ).
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF age IS SUPPLIED AND age >= 6.
          IF age > 64.
            cost_as_string = gt_baseprice * '0.4'.
            cost = ceil( cost_as_string ).
          ELSE.
            cost = ceil( gt_baseprice ).
          ENDIF.
        ELSE.
          cost = 0.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
