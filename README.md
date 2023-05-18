# ABAP-Lift-Pass-Pricing-Kata
## The Ski Lift Pass Pricing Kata for ABAP Devs!

This is the ABAP version of the infamous [Lift Pass Pricing Kata by Johann Martinson](https://github.com/martinsson/Refactoring-Kata-Lift-Pass-Pricing). Its a piece of software which calculates the price of a ski lift pass. I adapted it slightly to the ABAP world:
* includes some common ABAP problems
* no webservice infrastructure layer included
* 3 different versions of the kata

Your task is to refactor this ancient code so it is more readable and testable. Currently its a mess. There are four classes in this repository:
* ZPRICES_PREPARE_DATABASE - run this once to insert initial values into the database tables. Thats the configuration of the pricing-engine.
* ZPRICES_1 - the easiest version of the kata. start here if you are your students are quite new to refactoring and unit testing
* ZPRICES_2 - more dependencies for you to solve
* ZPRICES_3 - you guessed it - even more dependencies

## Give a Star! :star:
If you like or are using this project please give it a star. Thanks!

## New Features
When you are done with refactoring, you are not done done:
* Your PO calls you and tells you, that "your awesome software" has to integrate with external apps that will use it for cross-selling. The product vision is that people can buy snowboots via an online shopping app - and a lift pass. They can book a hotel via a portal - and a lift pass etc. Great, isnt it? To make your business logic available for external partners you need to set up a REST Webservice.
* Oh wow, those cross selling apps are a great success! Thats good. But some of the developers who use you API seem to use it wrong. /o\ Add some validation logic and make sure the DATE is >= today and <= today+6months. Also a person should only be allowed to buy a pass if he or she is at least 3 years old and a maximum of 70 years old (problems with the insurance...). Think about how these validations could be included in your system in a "good OO-style". Maybe you have heard of "value objects".

## Tipps
Techniques that will help you:
* rename variables
* extract method
* unit tests
* constants
* good naming
* delete unused variables
* etc.

Btw this kata (or any ABAP kata imho) is no fun to do with SE80. [Please use Eclipse/ADT](https://developers.sap.com/tutorials/abap-install-adt.html).

Enjoy! PRs are welcome.

Greetings,
Dominik

follow me on [Twittter](https://twitter.com/PanzerDominik) or [Mastodon](https://sw-development-is.social/web/@PanzerDominik)


