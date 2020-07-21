#!/bin/bash

echo ""
echo "Applying migration WhatIsTheCompanyName"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsTheCompanyName                        controllers.WhatIsTheCompanyNameController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsTheCompanyName                        controllers.WhatIsTheCompanyNameController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsTheCompanyName                  controllers.WhatIsTheCompanyNameController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsTheCompanyName                  controllers.WhatIsTheCompanyNameController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsTheCompanyName.title = whatIsTheCompanyName" >> ../conf/messages.en
echo "whatIsTheCompanyName.heading = whatIsTheCompanyName" >> ../conf/messages.en
echo "whatIsTheCompanyName.checkYourAnswersLabel = whatIsTheCompanyName" >> ../conf/messages.en
echo "whatIsTheCompanyName.error.required = Enter whatIsTheCompanyName" >> ../conf/messages.en
echo "whatIsTheCompanyName.error.length = WhatIsTheCompanyName must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheCompanyNameUserAnswersEntry: Arbitrary[(WhatIsTheCompanyNamePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsTheCompanyNamePage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheCompanyNamePage: Arbitrary[WhatIsTheCompanyNamePage.type] =";\
    print "    Arbitrary(WhatIsTheCompanyNamePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsTheCompanyNamePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsTheCompanyName: Option[Row] = userAnswers.get(WhatIsTheCompanyNamePage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsTheCompanyName.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsTheCompanyNameController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsTheCompanyName.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsTheCompanyName completed"
