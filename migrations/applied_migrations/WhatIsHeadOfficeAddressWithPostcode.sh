#!/bin/bash

echo ""
echo "Applying migration WhatIsHeadOfficeAddressUk"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsHeadOfficeAddressUk                        controllers.WhatIsHeadOfficeAddressUkController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsHeadOfficeAddressUk                        controllers.WhatIsHeadOfficeAddressUkController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsHeadOfficeAddressUk                  controllers.WhatIsHeadOfficeAddressUkController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsHeadOfficeAddressUk                  controllers.WhatIsHeadOfficeAddressUkController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.title = whatIsHeadOfficeAddressUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.heading = whatIsHeadOfficeAddressUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.AddressLineOne = AddressLineOne" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.AddressLineTwo = AddressLineTwo" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.checkYourAnswersLabel = whatIsHeadOfficeAddressUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.error.AddressLineOne.required = Enter AddressLineOne" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.error.AddressLineTwo.required = Enter AddressLineTwo" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.error.AddressLineOne.length = AddressLineOne must be 100 characters or less" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressUk.error.AddressLineTwo.length = AddressLineTwo must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressUkUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressUkPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsHeadOfficeAddressUkPage.type]";\
    print "        value <- arbitrary[WhatIsHeadOfficeAddressUk].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressUkPage: Arbitrary[WhatIsHeadOfficeAddressUkPage.type] =";\
    print "    Arbitrary(WhatIsHeadOfficeAddressUkPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressUk: Arbitrary[WhatIsHeadOfficeAddressUk] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        AddressLineOne <- arbitrary[String]";\
    print "        AddressLineTwo <- arbitrary[String]";\
    print "      } yield WhatIsHeadOfficeAddressUk(AddressLineOne, AddressLineTwo)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsHeadOfficeAddressUkPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsHeadOfficeAddressUk: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressUkPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsHeadOfficeAddressUk.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"${answer.AddressLineOne} ${answer.AddressLineTwo}\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsHeadOfficeAddressUkController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsHeadOfficeAddressUk.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsHeadOfficeAddressUk completed"
