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

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryIsTheGoverningCountryKnownPage: Arbitrary[IsTheGoverningCountryKnownPage.type] =
    Arbitrary(IsTheGoverningCountryKnownPage)

  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithPostcodePage: Arbitrary[WhatIsHeadOfficeAddressWithPostcodePage.type] =
    Arbitrary(WhatIsHeadOfficeAddressWithPostcodePage)

  implicit lazy val arbitraryWhatIsHeadOfficeAddressWithCountryPickerPage: Arbitrary[WhatIsHeadOfficeAddressWithCountryPickerPage.type] =
    Arbitrary(WhatIsHeadOfficeAddressWithCountryPickerPage)

  implicit lazy val arbitraryIsTheHeadOfficeLocationKnownPage: Arbitrary[IsTheHeadOfficeLocationKnownPage.type] =
    Arbitrary(IsTheHeadOfficeLocationKnownPage)

  implicit lazy val arbitraryWhatIsTheCompanyNamePage: Arbitrary[WhatIsTheCompanyNamePage.type] =
    Arbitrary(WhatIsTheCompanyNamePage)

  implicit lazy val arbitraryDoNonEEAOrgsHaveControllingInterestPage: Arbitrary[DoNonEEAOrgsHaveControllingInterestPage.type] =
    Arbitrary(DoNonEEAOrgsHaveControllingInterestPage)
}
