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

package generators

import models._
import org.scalacheck.Arbitrary
import org.scalacheck.Arbitrary.arbitrary
import pages._
import play.api.libs.json.{JsValue, Json}

trait UserAnswersEntryGenerators extends PageGenerators with ModelGenerators {

  implicit lazy val arbitraryDoYouWantToAddAnotherNonEEAOrganisationUserAnswersEntry: Arbitrary[(DoYouWantToAddAnotherNonEEAOrganisationPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouWantToAddAnotherNonEEAOrganisationPage.type]
        value <- arbitrary[DoYouWantToAddAnotherNonEEAOrganisation].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryIsHeadOfficeInUKUserAnswersEntry: Arbitrary[(IsHeadOfficeInUKPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IsHeadOfficeInUKPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhenDidTheCompanyLeaveTheTrustUserAnswersEntry: Arbitrary[(WhenDidTheCompanyLeaveTheTrustPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhenDidTheCompanyLeaveTheTrustPage.type]
        value <- arbitrary[Int].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryIsTheCompanyStillPartOfTheTrustUserAnswersEntry: Arbitrary[(IsTheCompanyStillPartOfTheTrustPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IsTheCompanyStillPartOfTheTrustPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhenDidTheCompanyBecomePartOfTheTrustUserAnswersEntry: Arbitrary[(WhenDidTheCompanyBecomePartOfTheTrustPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhenDidTheCompanyBecomePartOfTheTrustPage.type]
        value <- arbitrary[Int].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsTheGoverningCountryUserAnswersEntry: Arbitrary[(WhatIsTheGoverningCountryPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsTheGoverningCountryPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryIsTheGoverningCountryKnownUserAnswersEntry: Arbitrary[(IsTheGoverningCountryKnownPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IsTheGoverningCountryKnownPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsHeadOfficeAddressUkUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressUkPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsHeadOfficeAddressUkPage.type]
        value <- arbitrary[WhatIsHeadOfficeAddressUk].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsHeadOfficeAddressNonUkUserAnswersEntry: Arbitrary[(WhatIsHeadOfficeAddressNonUkPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsHeadOfficeAddressNonUkPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryIsTheHeadOfficeLocationKnownUserAnswersEntry: Arbitrary[(IsTheHeadOfficeLocationKnownPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IsTheHeadOfficeLocationKnownPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsTheCompanyNameUserAnswersEntry: Arbitrary[(WhatIsTheCompanyNamePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsTheCompanyNamePage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDoNonEEAOrgsHaveControllingInterestUserAnswersEntry: Arbitrary[(DoNonEEAOrgsHaveControllingInterestPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoNonEEAOrgsHaveControllingInterestPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }
}
