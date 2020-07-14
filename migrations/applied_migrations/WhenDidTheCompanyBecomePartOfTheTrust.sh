#!/bin/bash

echo ""
echo "Applying migration WhenDidTheCompanyBecomePartOfTheTrust"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whenDidTheCompanyBecomePartOfTheTrust                  controllers.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whenDidTheCompanyBecomePartOfTheTrust                  controllers.WhenDidTheCompanyBecomePartOfTheTrustController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhenDidTheCompanyBecomePartOfTheTrust                        controllers.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhenDidTheCompanyBecomePartOfTheTrust                        controllers.WhenDidTheCompanyBecomePartOfTheTrustController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.title = WhenDidTheCompanyBecomePartOfTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.heading = WhenDidTheCompanyBecomePartOfTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.hint = For example, 12 11 2007" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.checkYourAnswersLabel = WhenDidTheCompanyBecomePartOfTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.error.required.all = Enter the whenDidTheCompanyBecomePartOfTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.error.required.two = The whenDidTheCompanyBecomePartOfTheTrust" must include {0} and {1} >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.error.required = The whenDidTheCompanyBecomePartOfTheTrust must include {0}" >> ../conf/messages.en
echo "whenDidTheCompanyBecomePartOfTheTrust.error.invalid = Enter a real WhenDidTheCompanyBecomePartOfTheTrust" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidTheCompanyBecomePartOfTheTrustUserAnswersEntry: Arbitrary[(WhenDidTheCompanyBecomePartOfTheTrustPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhenDidTheCompanyBecomePartOfTheTrustPage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidTheCompanyBecomePartOfTheTrustPage: Arbitrary[WhenDidTheCompanyBecomePartOfTheTrustPage.type] =";\
    print "    Arbitrary(WhenDidTheCompanyBecomePartOfTheTrustPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhenDidTheCompanyBecomePartOfTheTrustPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whenDidTheCompanyBecomePartOfTheTrust: Option[Row] = userAnswers.get(WhenDidTheCompanyBecomePartOfTheTrustPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whenDidTheCompanyBecomePartOfTheTrust.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(Literal(answer.format(dateFormatter))),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whenDidTheCompanyBecomePartOfTheTrust.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhenDidTheCompanyBecomePartOfTheTrust completed"
