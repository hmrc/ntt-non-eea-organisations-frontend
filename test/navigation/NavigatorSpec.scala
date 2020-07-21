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

      "must go from Is the head office location known page to Is Head Office In UK" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IsTheHeadOfficeLocationKnownPage, NormalMode, answers)
              .mustBe(routes.IsHeadOfficeInUKController.onPageLoad(NormalMode))
        }
      }

      "must go from Is Head Office In UK  Head office address with country picker" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IsHeadOfficeInUKPage, NormalMode, answers)
              .mustBe(routes.WhatIsHeadOfficeAddressNonUkController.onPageLoad(NormalMode))
        }
      }

      "must go from Head office address with country picker, to Head office address with postcode" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhatIsHeadOfficeAddressNonUkPage, NormalMode, answers)
              .mustBe(routes.WhatIsHeadOfficeAddressUkController.onPageLoad(NormalMode))
        }
      }

      "must go from Head office address with postcode to Is governing country known" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhatIsHeadOfficeAddressUkPage, NormalMode, answers)
              .mustBe(routes.IsTheGoverningCountryKnownController.onPageLoad(NormalMode))
        }
      }
      "must go from Is governing country known to what is governing country?" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IsTheGoverningCountryKnownPage, NormalMode, answers)
              .mustBe(routes.WhatIsTheGoverningCountryController.onPageLoad(NormalMode))
        }
      }

      "must go from What is governing country? to When did the company become part of the trust" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhatIsTheGoverningCountryPage, NormalMode, answers)
              .mustBe(routes.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(NormalMode))
        }
      }
      "must go from When did the company become part of the trust to Is the company still a part of the trust" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhenDidTheCompanyBecomePartOfTheTrustPage, NormalMode, answers)
              .mustBe(routes.IsTheCompanyStillPartOfTheTrustController.onPageLoad(NormalMode))
        }
      }

      "must go from Is the company still a part of the trust to when did the company leave the trust" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(IsTheCompanyStillPartOfTheTrustPage, NormalMode, answers)
              .mustBe(routes.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(NormalMode))
        }
      }

      "must go from When did the company leave the trust to Check your answers" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(WhenDidTheCompanyLeaveTheTrustPage, NormalMode, answers)
              .mustBe(routes.CheckYourAnswersController.onPageLoad())
        }
      }

      "must go from Check your answers to Add another Non-EEA ORg page" in {
        forAll(arbitrary[UserAnswers]) {
          answers =>
            navigator.nextPage(CheckYourAnswersPage, NormalMode, answers)
              .mustBe(routes.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(NormalMode))
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
