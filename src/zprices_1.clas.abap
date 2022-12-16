CLASS zprices_1 DEFINITION
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



CLASS ZPRICES_1 IMPLEMENTATION.


  METHOD calculate_lift_pass_price.
    FIELD-SYMBOLS: <liftname> TYPE char30.
    DATA: lt_liftnames TYPE TABLE OF char30,
          ls_liftnames LIKE LINE OF lt_liftnames.
    DATA: low_tax TYPE f VALUE '0.16'.
    DATA: high_tax TYPE f VALUE '0.07'.
    DATA: vip TYPE abap_bool.

    SELECT SINGLE cost FROM zbase_prices WHERE type = @type INTO @DATA(ld_baseprice).

    IF age IS SUPPLIED AND age < 6.
      cost = 0.
    ELSE.
      IF type NE 'night'.
        IF age IS SUPPLIED AND age < 15.
          DATA(ld_cost_3) = CONV f( ld_baseprice * ( 1 -  30 / 100 ) ).
          cost = ceil( ld_cost_3 ).
        ELSE.
          IF age IS NOT SUPPLIED.
            cost = ceil( ld_baseprice ).
          ELSE.
            IF age > 64.
              DATA(ld_cost_4) = CONV f( ld_baseprice * ( 1 - 25 / 100  ) ).
              cost = ceil( ld_cost_4 ).
            ELSE.
              cost = ceil( ld_baseprice ).
            ENDIF.
          ENDIF.
        ENDIF.

      ELSE.
        IF age IS SUPPLIED AND age >= 6.
          IF age > 64.
            DATA(ld_cost_7) = CONV f( ld_baseprice * '0.4' ).
            cost = ceil( ld_cost_7 ).
          ELSE.
            cost =  ceil( ld_baseprice ).
          ENDIF.
        ELSE.
          cost = 0.
        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
