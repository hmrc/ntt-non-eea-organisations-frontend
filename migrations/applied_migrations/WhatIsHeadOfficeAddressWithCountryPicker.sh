#!/bin/bash

echo ""
echo "Applying migration WhatIsHeadOfficeAddressWithCountryPicker"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsHeadOfficeAddressWithCountryPicker                        controllers.WhatIsHeadOfficeAddressWithCountryPickerController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsHeadOfficeAddressWithCountryPicker                        controllers.WhatIsHeadOfficeAddressWithCountryPickerController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsHeadOfficeAddressWithCountryPicker                  controllers.WhatIsHeadOfficeAddressWithCountryPickerController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsHeadOfficeAddressWithCountryPicker                  controllers.WhatIsHeadOfficeAddressWithCountryPickerController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithCountryPicker.title = whatIsHeadOfficeAddressWithCountryPicker" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithCountryPicker.heading = whatIsHeadOfficeAddressWithCountryPicker" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithCountryPicker.checkYourAnswersLabel = whatIsHeadOfficeAddressWithCountryPicker" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithCountryPicker.error.required = Enter whatIsHeadOfficeAddressWithCountryPicker" >> ../conf/messages.en
echo "whatIsHeadOfficeAddressWithCountryPicker.error.length = WhatIsHeadOfficeAddressWithCountryPicker must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithCountryPickerUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressWithCountryPickerPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsHeadOfficeAddressWithCountryPickerPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithCountryPickerPage: Arbitrary[WhatIsHeadOfficeAddressWithCountryPickerPage.type] =";\
    print "    Arbitrary(WhatIsHeadOfficeAddressWithCountryPickerPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsHeadOfficeAddressWithCountryPickerPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsHeadOfficeAddressWithCountryPicker: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressWithCountryPickerPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsHeadOfficeAddressWithCountryPicker.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsHeadOfficeAddressWithCountryPickerController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsHeadOfficeAddressWithCountryPicker.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsHeadOfficeAddressWithCountryPicker completed"
