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

import play.api.data.Form
import play.api.i18n.Messages
import play.api.libs.json._
import uk.gov.hmrc.viewmodels._

sealed trait DoYouWantToAddAnotherNonEEAOrganisation

object DoYouWantToAddAnotherNonEEAOrganisation extends Enumerable.Implicits {

  case object YesIWantToAddThemNow extends WithName("yesIWantToAddThemNow") with DoYouWantToAddAnotherNonEEAOrganisation
  case object YesIWantWoAddThemLater extends WithName("yesIWantToAddThemLater") with DoYouWantToAddAnotherNonEEAOrganisation
  case object NoIHaveAddedAllNonEEAOrgs extends WithName("noIHaveAddedAllNonEEAOrgs") with DoYouWantToAddAnotherNonEEAOrganisation

  val values: Seq[DoYouWantToAddAnotherNonEEAOrganisation] = Seq(
    YesIWantToAddThemNow,
    YesIWantWoAddThemLater,
    NoIHaveAddedAllNonEEAOrgs
  )

  def radios(form: Form[_])(implicit messages: Messages): Seq[Radios.Item] = {

    val field = form("value")
    val items = Seq(
      Radios.Radio(msg"doYouWantToAddAnotherNonEEAOrganisation.yesIWantToAddThemNow", YesIWantToAddThemNow.toString),
      Radios.Radio(msg"doYouWantToAddAnotherNonEEAOrganisation.yesIWantToAddThemLater", YesIWantWoAddThemLater.toString),
      Radios.Radio(msg"doYouWantToAddAnotherNonEEAOrganisation.noIHaveAddedAllNonEEAOrgs", NoIHaveAddedAllNonEEAOrgs.toString)
    )

    Radios(field, items)
  }

  implicit val enumerable: Enumerable[DoYouWantToAddAnotherNonEEAOrganisation] =
    Enumerable(values.map(v => v.toString -> v): _*)
}
