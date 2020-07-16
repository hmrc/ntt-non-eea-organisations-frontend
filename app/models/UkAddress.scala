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

case class UkAddress(addressLineOne: String,
                     addressLineTwo: String,
                     addressLineThree: Option[String],
                     addressLineFour: Option[String],
                     postcode: String)

object UkAddress {
  implicit lazy val reads: Reads[UkAddress] = {
    (
      (__ \ "addressLineOne").read[String] and
      (__ \ "addressLineTwo").read[String] and
      (__ \ "addressLineThree").readNullable[String] and
      (__ \ "addressLineFour").readNullable[String] and
      (__ \ "postcode").read[String]
    ) (UkAddress.apply _)
  }

  implicit lazy val writes: OWrites[UkAddress] = {
    (
      (__ \ "addressLineOne").write[String] and
      (__ \ "addressLineTwo").write[String] and
      (__ \ "addressLineThree").writeNullable[String] and
      (__ \ "addressLineFour").writeNullable[String] and
      (__ \ "postcode").write[String]
      ) (unlift(UkAddress.unapply))
  }
}
