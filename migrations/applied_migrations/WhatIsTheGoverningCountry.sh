#!/bin/bash

echo ""
echo "Applying migration WhatIsTheGoverningCountry"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsTheGoverningCountry                        controllers.WhatIsTheGoverningCountryController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsTheGoverningCountry                        controllers.WhatIsTheGoverningCountryController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsTheGoverningCountry                  controllers.WhatIsTheGoverningCountryController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsTheGoverningCountry                  controllers.WhatIsTheGoverningCountryController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsTheGoverningCountry.title = whatIsTheGoverningCountry" >> ../conf/messages.en
echo "whatIsTheGoverningCountry.heading = whatIsTheGoverningCountry" >> ../conf/messages.en
echo "whatIsTheGoverningCountry.checkYourAnswersLabel = whatIsTheGoverningCountry" >> ../conf/messages.en
echo "whatIsTheGoverningCountry.error.required = Enter whatIsTheGoverningCountry" >> ../conf/messages.en
echo "whatIsTheGoverningCountry.error.length = WhatIsTheGoverningCountry must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheGoverningCountryUserAnswersEntry: Arbitrary[(WhatIsTheGoverningCountryPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsTheGoverningCountryPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheGoverningCountryPage: Arbitrary[WhatIsTheGoverningCountryPage.type] =";\
    print "    Arbitrary(WhatIsTheGoverningCountryPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsTheGoverningCountryPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsTheGoverningCountry: Option[Row] = userAnswers.get(WhatIsTheGoverningCountryPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsTheGoverningCountry.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsTheGoverningCountryController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsTheGoverningCountry.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsTheGoverningCountry completed"
