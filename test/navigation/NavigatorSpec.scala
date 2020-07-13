/*
 * Copyright 2020 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package navigation

import base.SpecBase
import controllers.routes
import generators.Generators
import pages._
import models._
import org.scalacheck.Arbitrary.arbitrary
import org.scalatestplus.scalacheck.ScalaCheckPropertyChecks

class NavigatorSpec extends SpecBase with ScalaCheckPropertyChecks with Generators {

  val navigator = new Navigator

  "Navigator" - {

    "in Normal mode" - {

      "must go from a page that doesn't exist in the route map to Index" in {

        case object UnknownPage extends Page

        forAll(arbitrary[UserAnswers]) {
          answers =>

            navigator.nextPage(UnknownPage, NormalMode, answers)
              .mustBe(routes.IndexController.onPageLoad())
        }
      }

      "must go from Index to About this section page" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IndexPage, NormalMode, answers)
              .mustBe(routes.AboutThisSectionController.onPageLoad())
        }
      }

      "must go from About this section page to Do Non-EEA Orgs Have Controlling Interest" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(AboutThisSectionPage, NormalMode, answers)
              .mustBe(routes.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(NormalMode))
        }
      }

      "must go from Do Non-EEA Orgs Have Controlling Interest to What is the company name page" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(DoNonEEAOrgsHaveControllingInterestPage, NormalMode, answers)
              .mustBe(routes.WhatIsTheCompanyNameController.onPageLoad(NormalMode))
        }
      }

      "must go from What is the company name page to Is the head office location known page" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhatIsTheCompanyNamePage, NormalMode, answers)
              .mustBe(routes.IsTheHeadOfficeLocationKnownController.onPageLoad(NormalMode))
        }
      }

      "must go from Is the head office location known page to Head office address with country picker" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IsTheHeadOfficeLocationKnownPage, NormalMode, answers)
              .mustBe(routes.WhatIsHeadOfficeAddressWithCountryPickerController.onPageLoad(NormalMode))
        }
      }

    }

    "in Check mode" - {

      "must go from a page that doesn't exist in the edit route map  to Check Your Answers" in {

        case object UnknownPage extends Page

        forAll(arbitrary[UserAnswers]) {
          answers =>

            navigator.nextPage(UnknownPage, CheckMode, answers)
              .mustBe(routes.CheckYourAnswersController.onPageLoad())
        }
      }
    }
  }
}