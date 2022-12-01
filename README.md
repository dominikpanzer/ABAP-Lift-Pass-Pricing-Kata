# ABAP-Lift-Pass-Pricing-Kata
Lift Pass Pricing Kata ABAP

This is the ABAP version of the infamous Lift Pass Pricing Kata by Johann Martinson. Its a piece of software which calculates the price of a ski lift pass. I adapted it slightly to the ABAP world:
* includes some common ABAP problems
* no webservice infrastructe layer
* 3 different versions of the kata

Your task is to refactor this ancient code so it is more readable and testable. Currently its a mess. There are four classes in this repository:
* ZPRICES_PREPARE_DATABASE - run this once to insert initial values into the database tables. Thats the configuration of the pricing-engine.
* ZPRICES_1 - the easiest version of the kata. start here if you are your students are quite new to refactoring and unit testing
* ZPRICES_2 - more dependencies for you to solve
* ZPRICES_3 - you guessed it - even more dependencies

When you are done with refactoring, you are not done done:
* Your PO calls you and tells you, that "your awesome software" will be used for external apps that will do cross-selling. So people can buy snowboots via an online shopping app - and a lift pass. They can book a hotel via a portal - and a lift pass etc. Great. To make your business logic available for external partners you need to set up a REST Webservice.
* Oh wow, those cross selling apps are a great success! Thats good. but some of the developers who use you API seem to use it wrong. /o\ Add some validation logic and make sure the DATE is >= today and <= today+6months. Also a person should only be allowed to buy a pass if he or she is at least 3 years old and a maximum of 70 years old (problems with the insurance...). Think about how these validations could be included in your system in a "good OO-style". Maybe you have heard of "value objects".

Techniques that will help you:
-rename variables
-extract method
-unit Tests
-contants
-good naming
-delete unused variables
-etc.

Btw this kata (or any kata imho) is no fun with SE80. Please use Eclipse/ADT.

Enjoy! PRs are welcome.

Greetings,
Dominik

https://twitter.com/PanzerDominik
@PanzerDominik@sw-development-is.social

