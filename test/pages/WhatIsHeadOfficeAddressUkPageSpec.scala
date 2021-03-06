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

package pages

import models.{UkAddress, WhatIsHeadOfficeAddressUk}
import org.scalacheck.{Arbitrary, Gen}
import pages.behaviours.PageBehaviours

class WhatIsHeadOfficeAddressUkPageSpec extends PageBehaviours {

  "WhatIsHeadOfficeAddressUkPage" - {

    implicit val arb: Arbitrary[UkAddress] = Arbitrary(Gen.const(UkAddress("line1", "line2", Some("line3"), Some("line4"), "postcode")))

    beRetrievable[UkAddress](WhatIsHeadOfficeAddressUkPage)

    beSettable[UkAddress](WhatIsHeadOfficeAddressUkPage)

    beRemovable[UkAddress](WhatIsHeadOfficeAddressUkPage)
  }
}
