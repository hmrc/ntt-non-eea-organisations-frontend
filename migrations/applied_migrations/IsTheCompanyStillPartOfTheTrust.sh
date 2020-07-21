#!/bin/bash

echo ""
echo "Applying migration IsTheCompanyStillPartOfTheTrust"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isTheCompanyStillPartOfTheTrust                        controllers.IsTheCompanyStillPartOfTheTrustController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isTheCompanyStillPartOfTheTrust                        controllers.IsTheCompanyStillPartOfTheTrustController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsTheCompanyStillPartOfTheTrust                  controllers.IsTheCompanyStillPartOfTheTrustController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsTheCompanyStillPartOfTheTrust                  controllers.IsTheCompanyStillPartOfTheTrustController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isTheCompanyStillPartOfTheTrust.title = isTheCompanyStillPartOfTheTrust" >> ../conf/messages.en
echo "isTheCompanyStillPartOfTheTrust.heading = isTheCompanyStillPartOfTheTrust" >> ../conf/messages.en
echo "isTheCompanyStillPartOfTheTrust.checkYourAnswersLabel = isTheCompanyStillPartOfTheTrust" >> ../conf/messages.en
echo "isTheCompanyStillPartOfTheTrust.error.required = Select yes if isTheCompanyStillPartOfTheTrust" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheCompanyStillPartOfTheTrustUserAnswersEntry: Arbitrary[(IsTheCompanyStillPartOfTheTrustPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsTheCompanyStillPartOfTheTrustPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheCompanyStillPartOfTheTrustPage: Arbitrary[IsTheCompanyStillPartOfTheTrustPage.type] =";\
    print "    Arbitrary(IsTheCompanyStillPartOfTheTrustPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsTheCompanyStillPartOfTheTrustPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def isTheCompanyStillPartOfTheTrust: Option[Row] = userAnswers.get(IsTheCompanyStillPartOfTheTrustPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"isTheCompanyStillPartOfTheTrust.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.IsTheCompanyStillPartOfTheTrustController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"isTheCompanyStillPartOfTheTrust.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration IsTheCompanyStillPartOfTheTrust completed"
