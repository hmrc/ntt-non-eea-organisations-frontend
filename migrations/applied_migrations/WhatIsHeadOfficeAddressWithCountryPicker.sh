#!/bin/bash

echo ""
echo "Applying migration WhatIsHeadOfficeAddressNonUk"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsHeadOfficeAddressNonUk                        controllers.WhatIsHeadOfficeAddressNonUkController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsHeadOfficeAddressNonUk                        controllers.WhatIsHeadOfficeAddressNonUkController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsHeadOfficeAddressNonUk                  controllers.WhatIsHeadOfficeAddressNonUkController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsHeadOfficeAddressNonUk                  controllers.WhatIsHeadOfficeAddressNonUkController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressNonUk.title = whatIsHeadOfficeAddressNonUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressNonUk.heading = whatIsHeadOfficeAddressNonUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressNonUk.checkYourAnswersLabel = whatIsHeadOfficeAddressNonUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressNonUk.error.required = Enter whatIsHeadOfficeAddressNonUk" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressNonUk.error.length = WhatIsHeadOfficeAddressNonUk must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressNonUkUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressNonUkPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsHeadOfficeAddressNonUkPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressNonUkPage: Arbitrary[WhatIsHeadOfficeAddressNonUkPage.type] =";\
    print "    Arbitrary(WhatIsHeadOfficeAddressNonUkPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsHeadOfficeAddressNonUkPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsHeadOfficeAddressNonUk: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressNonUkPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsHeadOfficeAddressNonUk.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsHeadOfficeAddressNonUkController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsHeadOfficeAddressNonUk.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsHeadOfficeAddressNonUk completed"
