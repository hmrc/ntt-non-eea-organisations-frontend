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
import models.NonUkAddress
import play.api.data.Form
import play.api.data.Forms._

class WhatIsHeadOfficeAddressWithCountryPickerFormProvider @Inject() extends Mappings {

  def apply(): Form[NonUkAddress] = Form(
      mapping (
        "AddressLineOne" -> text("whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineOne.required")
          .verifying(maxLength(100, "whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineOne.length")),
        "AddressLineTwo" -> text("whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineTwo.required")
          .verifying(maxLength(100, "whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineTwo.length")),
        "AddressLineThree" -> optionalText().verifying(optMaxLength(100, "whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineThree.length")),
        "AddressLineFour" -> optionalText().verifying(optMaxLength(100, "whatIsHeadOfficeAddressWithCountryPicker.error.AddressLineFour.length")),
        "Country" -> text("whatIsHeadOfficeAddressWithCountryPicker.error.Country.required")
          .verifying(maxLength(100, "whatIsHeadOfficeAddressWithCountryPicker.error.Country.length"))
      ) (NonUkAddress.apply) (NonUkAddress.unapply)
    )
}
