#!/bin/bash

echo ""
echo "Applying migration DoNonEEAOrgsHaveControllingInterest"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doNonEEAOrgsHaveControllingInterest                        controllers.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doNonEEAOrgsHaveControllingInterest                        controllers.DoNonEEAOrgsHaveControllingInterestController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoNonEEAOrgsHaveControllingInterest                  controllers.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoNonEEAOrgsHaveControllingInterest                  controllers.DoNonEEAOrgsHaveControllingInterestController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doNonEEAOrgsHaveControllingInterest.title = doNonEEAOrgsHaveControllingInterest" >> ../conf/messages.en
echo "doNonEEAOrgsHaveControllingInterest.heading = doNonEEAOrgsHaveControllingInterest" >> ../conf/messages.en
echo "doNonEEAOrgsHaveControllingInterest.checkYourAnswersLabel = doNonEEAOrgsHaveControllingInterest" >> ../conf/messages.en
echo "doNonEEAOrgsHaveControllingInterest.error.required = Select yes if doNonEEAOrgsHaveControllingInterest" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoNonEEAOrgsHaveControllingInterestUserAnswersEntry: Arbitrary[(DoNonEEAOrgsHaveControllingInterestPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoNonEEAOrgsHaveControllingInterestPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoNonEEAOrgsHaveControllingInterestPage: Arbitrary[DoNonEEAOrgsHaveControllingInterestPage.type] =";\
    print "    Arbitrary(DoNonEEAOrgsHaveControllingInterestPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoNonEEAOrgsHaveControllingInterestPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doNonEEAOrgsHaveControllingInterest: Option[Row] = userAnswers.get(DoNonEEAOrgsHaveControllingInterestPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doNonEEAOrgsHaveControllingInterest.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doNonEEAOrgsHaveControllingInterest.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoNonEEAOrgsHaveControllingInterest completed"
