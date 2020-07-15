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
import models.{CheckMode, UkAddress, UserAnswers}
import pages._
import play.api.i18n.Messages
import CheckYourAnswersHelper._
import uk.gov.hmrc.viewmodels._
import uk.gov.hmrc.viewmodels.SummaryList._
import uk.gov.hmrc.viewmodels.Text.Literal

class CheckYourAnswersHelper(userAnswers: UserAnswers)(implicit messages: Messages) {

  def whenDidTheCompanyLeaveTheTrust: Option[Row] = userAnswers.get(WhenDidTheCompanyLeaveTheTrustPage) map {
    answer =>
      Row(
        key     = Key(msg"whenDidTheCompanyLeaveTheTrust.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(Literal(answer.format(dateFormatter))),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whenDidTheCompanyLeaveTheTrust.checkYourAnswersLabel"))
          )
        )
      )
  }

  def isTheCompanyStillPartOfTheTrust: Option[Row] = userAnswers.get(IsTheCompanyStillPartOfTheTrustPage) map {
    answer =>
      Row(
        key     = Key(msg"isTheCompanyStillPartOfTheTrust.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.IsTheCompanyStillPartOfTheTrustController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"isTheCompanyStillPartOfTheTrust.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whenDidTheCompanyBecomePartOfTheTrust: Option[Row] = userAnswers.get(WhenDidTheCompanyBecomePartOfTheTrustPage) map {
    answer =>
      Row(
        key     = Key(msg"whenDidTheCompanyBecomePartOfTheTrust.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(Literal(answer.format(dateFormatter))),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whenDidTheCompanyBecomePartOfTheTrust.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsTheGoverningCountry: Option[Row] = userAnswers.get(WhatIsTheGoverningCountryPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsTheGoverningCountry.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsTheGoverningCountryController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsTheGoverningCountry.checkYourAnswersLabel"))
          )
        )
      )
  }

  def isTheGoverningCountryKnown: Option[Row] = userAnswers.get(IsTheGoverningCountryKnownPage) map {
    answer =>
      Row(
        key     = Key(msg"isTheGoverningCountryKnown.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.IsTheGoverningCountryKnownController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"isTheGoverningCountryKnown.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsHeadOfficeAddressWithPostcode: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressWithPostcodePage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsHeadOfficeAddressWithPostcode.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(address(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsHeadOfficeAddressWithPostcodeController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsHeadOfficeAddressWithPostcode.checkYourAnswersLabel"))
          )
        )
      )
  }

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

  private def address(address: UkAddress): Content = {
    lit"${address.AddressLineOne}, ${address.AddressLineTwo}, ${address.AddressLineThree}, ${address.AddressLineFour}, ${address.Postcode}"
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
