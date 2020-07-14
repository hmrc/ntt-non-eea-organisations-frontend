#!/bin/bash

echo ""
echo "Applying migration WhatIsHeadOfficeAddressWithPostcode"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsHeadOfficeAddressWithPostcode                        controllers.WhatIsHeadOfficeAddressWithPostcodeController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsHeadOfficeAddressWithPostcode                        controllers.WhatIsHeadOfficeAddressWithPostcodeController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsHeadOfficeAddressWithPostcode                  controllers.WhatIsHeadOfficeAddressWithPostcodeController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsHeadOfficeAddressWithPostcode                  controllers.WhatIsHeadOfficeAddressWithPostcodeController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.title = whatIsHeadOfficeAddressWithPostcode" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.heading = whatIsHeadOfficeAddressWithPostcode" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.AddressLineOne = AddressLineOne" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.AddressLineTwo = AddressLineTwo" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.checkYourAnswersLabel = whatIsHeadOfficeAddressWithPostcode" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.required = Enter AddressLineOne" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.required = Enter AddressLineTwo" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.length = AddressLineOne must be 100 characters or less" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.length = AddressLineTwo must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithPostcodeUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressWithPostcodePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsHeadOfficeAddressWithPostcodePage.type]";\
    print "        value <- arbitrary[WhatIsHeadOfficeAddressWithPostcode].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithPostcodePage: Arbitrary[WhatIsHeadOfficeAddressWithPostcodePage.type] =";\
    print "    Arbitrary(WhatIsHeadOfficeAddressWithPostcodePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithPostcode: Arbitrary[WhatIsHeadOfficeAddressWithPostcode] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        AddressLineOne <- arbitrary[String]";\
    print "        AddressLineTwo <- arbitrary[String]";\
    print "      } yield WhatIsHeadOfficeAddressWithPostcode(AddressLineOne, AddressLineTwo)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsHeadOfficeAddressWithPostcodePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsHeadOfficeAddressWithPostcode: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressWithPostcodePage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsHeadOfficeAddressWithPostcode.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"${answer.AddressLineOne} ${answer.AddressLineTwo}\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsHeadOfficeAddressWithPostcodeController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsHeadOfficeAddressWithPostcode.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsHeadOfficeAddressWithPostcode completed"
