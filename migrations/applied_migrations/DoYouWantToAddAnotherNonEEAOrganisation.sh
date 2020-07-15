#!/bin/bash

echo ""
echo "Applying migration DoYouWantToAddAnotherNonEEAOrganisation"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doYouWantToAddAnotherNonEEAOrganisation                        controllers.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doYouWantToAddAnotherNonEEAOrganisation                        controllers.DoYouWantToAddAnotherNonEEAOrganisationController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoYouWantToAddAnotherNonEEAOrganisation                  controllers.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoYouWantToAddAnotherNonEEAOrganisation                  controllers.DoYouWantToAddAnotherNonEEAOrganisationController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.title = doYouWantToAddAnotherNonEEAOrganisation" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.heading = doYouWantToAddAnotherNonEEAOrganisation" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.yesIWantToAddThemNow = YesIWantToAddThemNow" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.yesIWantToAddThemLater = YesIWantToAddThemLater" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.checkYourAnswersLabel = doYouWantToAddAnotherNonEEAOrganisation" >> ../conf/messages.en
echo "doYouWantToAddAnotherNonEEAOrganisation.error.required = Select doYouWantToAddAnotherNonEEAOrganisation" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherNonEEAOrganisationUserAnswersEntry: Arbitrary[(DoYouWantToAddAnotherNonEEAOrganisationPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoYouWantToAddAnotherNonEEAOrganisationPage.type]";\
    print "        value <- arbitrary[DoYouWantToAddAnotherNonEEAOrganisation].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherNonEEAOrganisationPage: Arbitrary[DoYouWantToAddAnotherNonEEAOrganisationPage.type] =";\
    print "    Arbitrary(DoYouWantToAddAnotherNonEEAOrganisationPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherNonEEAOrganisation: Arbitrary[DoYouWantToAddAnotherNonEEAOrganisation] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(DoYouWantToAddAnotherNonEEAOrganisation.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoYouWantToAddAnotherNonEEAOrganisationPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doYouWantToAddAnotherNonEEAOrganisation: Option[Row] = userAnswers.get(DoYouWantToAddAnotherNonEEAOrganisationPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doYouWantToAddAnotherNonEEAOrganisation.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(msg\"doYouWantToAddAnotherNonEEAOrganisation.$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doYouWantToAddAnotherNonEEAOrganisation.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoYouWantToAddAnotherNonEEAOrganisation completed"
