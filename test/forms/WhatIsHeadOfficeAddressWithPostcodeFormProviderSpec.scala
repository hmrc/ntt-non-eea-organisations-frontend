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

import forms.behaviours.StringFieldBehaviours
import play.api.data.FormError

class WhatIsHeadOfficeAddressWithPostcodeFormProviderSpec extends StringFieldBehaviours {

  val form = new WhatIsHeadOfficeAddressWithPostcodeFormProvider()()

  ".AddressLineOne" - {

    val fieldName = "AddressLineOne"
    val requiredKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.required"
    val lengthKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineOne.length"
    val maxLength = 100

    behave like fieldThatBindsValidData(
      form,
      fieldName,
      stringsWithMaxLength(maxLength)
    )

    behave like fieldWithMaxLength(
      form,
      fieldName,
      maxLength = maxLength,
      lengthError = FormError(fieldName, lengthKey, Seq(maxLength))
    )

    behave like mandatoryField(
      form,
      fieldName,
      requiredError = FormError(fieldName, requiredKey)
    )
  }

  ".AddressLineTwo" - {

    val fieldName = "AddressLineTwo"
    val requiredKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.required"
    val lengthKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineTwo.length"
    val maxLength = 100

    behave like fieldThatBindsValidData(
      form,
      fieldName,
      stringsWithMaxLength(maxLength)
    )

    behave like fieldWithMaxLength(
      form,
      fieldName,
      maxLength = maxLength,
      lengthError = FormError(fieldName, lengthKey, Seq(maxLength))
    )

    behave like mandatoryField(
      form,
      fieldName,
      requiredError = FormError(fieldName, requiredKey)
    )
  }

  ".AddressLineThree" - {

    val fieldName = "AddressLineThree"

    val lengthKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineThree.length"
    val maxLength = 100

    behave like fieldThatBindsValidData(
      form,
      fieldName,
      stringsWithMaxLength(maxLength)
    )

    behave like fieldWithMaxLength(
      form,
      fieldName,
      maxLength = maxLength,
      lengthError = FormError(fieldName, lengthKey, Seq(maxLength))
    )
  }

  ".AddressLineFour" - {

    val fieldName = "AddressLineFour"

    val lengthKey = "whatIsHeadOfficeAddressWithPostcode.error.AddressLineFour.length"
    val maxLength = 100

    behave like fieldThatBindsValidData(
      form,
      fieldName,
      stringsWithMaxLength(maxLength)
    )

    behave like fieldWithMaxLength(
      form,
      fieldName,
      maxLength = maxLength,
      lengthError = FormError(fieldName, lengthKey, Seq(maxLength))
    )
  }

  ".Postcode" - {

    val fieldName = "Postcode"
    val requiredKey = "whatIsHeadOfficeAddressWithPostcode.error.Postcode.required"
    val lengthKey = "whatIsHeadOfficeAddressWithPostcode.error.Postcode.length"
    val maxLength = 8

    behave like fieldThatBindsValidData(
      form,
      fieldName,
      stringsWithMaxLength(maxLength)
    )

    behave like fieldWithMaxLength(
      form,
      fieldName,
      maxLength = maxLength,
      lengthError = FormError(fieldName, lengthKey, Seq(maxLength))
    )

    behave like mandatoryField(
      form,
      fieldName,
      requiredError = FormError(fieldName, requiredKey)
    )
  }
}
