#!/bin/bash

echo ""
echo "Applying migration WhenDidTheCompanyLeaveTheTrust"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whenDidTheCompanyLeaveTheTrust                  controllers.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whenDidTheCompanyLeaveTheTrust                  controllers.WhenDidTheCompanyLeaveTheTrustController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhenDidTheCompanyLeaveTheTrust                        controllers.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhenDidTheCompanyLeaveTheTrust                        controllers.WhenDidTheCompanyLeaveTheTrustController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.title = WhenDidTheCompanyLeaveTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.heading = WhenDidTheCompanyLeaveTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.hint = For example, 12 11 2007" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.checkYourAnswersLabel = WhenDidTheCompanyLeaveTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.error.required.all = Enter the whenDidTheCompanyLeaveTheTrust" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.error.required.two = The whenDidTheCompanyLeaveTheTrust" must include {0} and {1} >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.error.required = The whenDidTheCompanyLeaveTheTrust must include {0}" >> ../conf/messages.en
echo "whenDidTheCompanyLeaveTheTrust.error.invalid = Enter a real WhenDidTheCompanyLeaveTheTrust" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidTheCompanyLeaveTheTrustUserAnswersEntry: Arbitrary[(WhenDidTheCompanyLeaveTheTrustPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhenDidTheCompanyLeaveTheTrustPage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhenDidTheCompanyLeaveTheTrustPage: Arbitrary[WhenDidTheCompanyLeaveTheTrustPage.type] =";\
    print "    Arbitrary(WhenDidTheCompanyLeaveTheTrustPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhenDidTheCompanyLeaveTheTrustPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whenDidTheCompanyLeaveTheTrust: Option[Row] = userAnswers.get(WhenDidTheCompanyLeaveTheTrustPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whenDidTheCompanyLeaveTheTrust.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(Literal(answer.format(dateFormatter))),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whenDidTheCompanyLeaveTheTrust.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhenDidTheCompanyLeaveTheTrust completed"
