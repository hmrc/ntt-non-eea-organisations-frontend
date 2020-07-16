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

package models

import play.api.libs.json.{OWrites, Reads, __}
import play.api.libs.functional.syntax._

case class NonUkAddress(AddressLineOne: String,
                        AddressLineTwo: String,
                        AddressLineThree: Option[String],
                        AddressLineFour : Option[String],
                        Country: String)

object NonUkAddress {
  implicit lazy val reads: Reads[NonUkAddress] = {
    (
        (__ \ "AddressLineOne").read[String] and
        (__ \ "AddressLineTwo").read[String] and
        (__ \ "AddressLineThree").readNullable[String] and
        (__ \ "AddressLineFour").readNullable[String] and
        (__ \ "Country").read[String]
    ) (NonUkAddress.apply _)
  }

  implicit lazy val writes: OWrites[NonUkAddress] = {
    (
        (__ \ "AddressLineOne").write[String] and
        (__ \ "AddressLineTwo").write[String] and
        (__ \ "AddressLineThree").writeNullable[String] and
        (__ \ "AddressLineFour").writeNullable[String] and
        (__ \ "Country").write[String]
    ) (unlift(NonUkAddress.unapply))
  }
}
