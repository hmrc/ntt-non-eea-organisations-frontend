#!/bin/bash

echo ""
echo "Applying migration IsTheGoverningCountryKnown"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isTheGoverningCountryKnown                        controllers.IsTheGoverningCountryKnownController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isTheGoverningCountryKnown                        controllers.IsTheGoverningCountryKnownController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsTheGoverningCountryKnown                  controllers.IsTheGoverningCountryKnownController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsTheGoverningCountryKnown                  controllers.IsTheGoverningCountryKnownController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isTheGoverningCountryKnown.title = isTheGoverningCountryKnown" >> ../conf/messages.en
echo "isTheGoverningCountryKnown.heading = isTheGoverningCountryKnown" >> ../conf/messages.en
echo "isTheGoverningCountryKnown.checkYourAnswersLabel = isTheGoverningCountryKnown" >> ../conf/messages.en
echo "isTheGoverningCountryKnown.error.required = Select yes if isTheGoverningCountryKnown" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheGoverningCountryKnownUserAnswersEntry: Arbitrary[(IsTheGoverningCountryKnownPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsTheGoverningCountryKnownPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheGoverningCountryKnownPage: Arbitrary[IsTheGoverningCountryKnownPage.type] =";\
    print "    Arbitrary(IsTheGoverningCountryKnownPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsTheGoverningCountryKnownPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def isTheGoverningCountryKnown: Option[Row] = userAnswers.get(IsTheGoverningCountryKnownPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"isTheGoverningCountryKnown.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.IsTheGoverningCountryKnownController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"isTheGoverningCountryKnown.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration IsTheGoverningCountryKnown completed"
