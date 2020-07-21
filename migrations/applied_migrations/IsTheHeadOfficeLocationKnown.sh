#!/bin/bash

echo ""
echo "Applying migration IsTheHeadOfficeLocationKnown"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isTheHeadOfficeLocationKnown                        controllers.IsTheHeadOfficeLocationKnownController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isTheHeadOfficeLocationKnown                        controllers.IsTheHeadOfficeLocationKnownController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsTheHeadOfficeLocationKnown                  controllers.IsTheHeadOfficeLocationKnownController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsTheHeadOfficeLocationKnown                  controllers.IsTheHeadOfficeLocationKnownController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isTheHeadOfficeLocationKnown.title = isTheHeadOfficeLocationKnown" >> ../conf/messages.en
echo "isTheHeadOfficeLocationKnown.heading = isTheHeadOfficeLocationKnown" >> ../conf/messages.en
echo "isTheHeadOfficeLocationKnown.checkYourAnswersLabel = isTheHeadOfficeLocationKnown" >> ../conf/messages.en
echo "isTheHeadOfficeLocationKnown.error.required = Select yes if isTheHeadOfficeLocationKnown" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheHeadOfficeLocationKnownUserAnswersEntry: Arbitrary[(IsTheHeadOfficeLocationKnownPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsTheHeadOfficeLocationKnownPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsTheHeadOfficeLocationKnownPage: Arbitrary[IsTheHeadOfficeLocationKnownPage.type] =";\
    print "    Arbitrary(IsTheHeadOfficeLocationKnownPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsTheHeadOfficeLocationKnownPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def isTheHeadOfficeLocationKnown: Option[Row] = userAnswers.get(IsTheHeadOfficeLocationKnownPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"isTheHeadOfficeLocationKnown.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.IsTheHeadOfficeLocationKnownController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"isTheHeadOfficeLocationKnown.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration IsTheHeadOfficeLocationKnown completed"
