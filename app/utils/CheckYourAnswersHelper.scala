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

package utils

import java.time.format.DateTimeFormatter

import controllers.routes
import models.{CheckMode, UserAnswers}
import pages._
import play.api.i18n.Messages
import CheckYourAnswersHelper._
import uk.gov.hmrc.viewmodels._
import uk.gov.hmrc.viewmodels.SummaryList._
import uk.gov.hmrc.viewmodels.Text.Literal

class CheckYourAnswersHelper(userAnswers: UserAnswers)(implicit messages: Messages) {

  def whatIsHeadOfficeAddressWithCountryPicker: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressWithCountryPickerPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsHeadOfficeAddressWithCountryPicker.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsHeadOfficeAddressWithCountryPickerController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsHeadOfficeAddressWithCountryPicker.checkYourAnswersLabel"))
          )
        )
      )
  }

  def isTheHeadOfficeLocationKnown: Option[Row] = userAnswers.get(IsTheHeadOfficeLocationKnownPage) map {
    answer =>
      Row(
        key     = Key(msg"isTheHeadOfficeLocationKnown.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.IsTheHeadOfficeLocationKnownController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"isTheHeadOfficeLocationKnown.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsTheCompanyName: Option[Row] = userAnswers.get(WhatIsTheCompanyNamePage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsTheCompanyName.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsTheCompanyNameController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsTheCompanyName.checkYourAnswersLabel"))
          )
        )
      )
  }

  def doNonEEAOrgsHaveControllingInterest: Option[Row] = userAnswers.get(DoNonEEAOrgsHaveControllingInterestPage) map {
    answer =>
      Row(
        key     = Key(msg"doNonEEAOrgsHaveControllingInterest.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doNonEEAOrgsHaveControllingInterest.checkYourAnswersLabel"))
          )
        )
      )
  }

  private def yesOrNo(answer: Boolean): Content =
    if (answer) {
      msg"site.yes"
    } else {
      msg"site.no"
    }
}

object CheckYourAnswersHelper {

  private val dateFormatter = DateTimeFormatter.ofPattern("d MMMM yyyy")
}