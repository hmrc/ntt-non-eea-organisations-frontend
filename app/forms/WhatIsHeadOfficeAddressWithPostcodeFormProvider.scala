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

package forms

import javax.inject.Inject
import forms.mappings.Mappings
import play.api.data.Form
import play.api.data.Forms._
import models.{UkAddress, WhatIsHeadOfficeAddressWithPostcode}

class WhatIsHeadOfficeAddressWithPostcodeFormProvider @Inject() extends Mappings {

   def apply(): Form[UkAddress] = Form(
     mapping(
      "AddressLineOne" -> text("whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.required")
        .verifying(maxLength(100, "whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.length")),
      "AddressLineTwo" -> text("whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.required")
        .verifying(maxLength(100, "whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.length")),
       "AddressLineThree" -> text("whatIsHeadOfficeAddressWithPostcode.error.AddressLineThree.required")
         .verifying(maxLength(100, "whatIsHeadOfficeAddressWithPostcode.error.AddressLineThree.length")),
       "AddressLineFour" -> text("whatIsHeadOfficeAddressWithPostcode.error.AddressLineFour.required")
         .verifying(maxLength(100, "whatIsHeadOfficeAddressWithPostcode.error.AddressLineFour.length")),
       "Postcode" -> text("whatIsHeadOfficeAddressWithPostcode.error.Postcode.required")
         .verifying(maxLength(8, "whatIsHeadOfficeAddressWithPostcode.error.Postcode.length"))
    )(UkAddress.apply)(UkAddress.unapply)
   )
 }
