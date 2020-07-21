#!/bin/bash

echo ""
echo "Applying migration IsHeadOfficeInUK"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isHeadOfficeInUK                        controllers.IsHeadOfficeInUKController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isHeadOfficeInUK                        controllers.IsHeadOfficeInUKController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsHeadOfficeInUK                  controllers.IsHeadOfficeInUKController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsHeadOfficeInUK                  controllers.IsHeadOfficeInUKController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isHeadOfficeInUK.title = isHeadOfficeInUK" >> ../conf/messages.en
echo "isHeadOfficeInUK.heading = isHeadOfficeInUK" >> ../conf/messages.en
echo "isHeadOfficeInUK.checkYourAnswersLabel = isHeadOfficeInUK" >> ../conf/messages.en
echo "isHeadOfficeInUK.error.required = Select yes if isHeadOfficeInUK" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsHeadOfficeInUKUserAnswersEntry: Arbitrary[(IsHeadOfficeInUKPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsHeadOfficeInUKPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsHeadOfficeInUKPage: Arbitrary[IsHeadOfficeInUKPage.type] =";\
    print "    Arbitrary(IsHeadOfficeInUKPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsHeadOfficeInUKPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def isHeadOfficeInUK: Option[Row] = userAnswers.get(IsHeadOfficeInUKPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"isHeadOfficeInUK.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.IsHeadOfficeInUKController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"isHeadOfficeInUK.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration IsHeadOfficeInUK completed"
