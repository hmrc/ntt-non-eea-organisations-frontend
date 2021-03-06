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
import models.{CheckMode, NonUkAddress, UkAddress, UserAnswers}
import pages._
import play.api.i18n.Messages
import CheckYourAnswersHelper._
import services.CountryService
import uk.gov.hmrc.viewmodels._
import uk.gov.hmrc.viewmodels.SummaryList._
import uk.gov.hmrc.viewmodels.Text.Literal

class CheckYourAnswersHelper(userAnswers: UserAnswers, countryService: CountryService)(implicit messages: Messages) {

  def doYouWantToAddAnotherNonEEAOrganisation: Option[Row] = userAnswers.get(DoYouWantToAddAnotherNonEEAOrganisationPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouWantToAddAnotherNonEEAOrganisation.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(msg"doYouWantToAddAnotherNonEEAOrganisation.$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouWantToAddAnotherNonEEAOrganisation.checkYourAnswersLabel"))
          )
        )
      )
  }

  def isHeadOfficeInUK: Option[Row] = userAnswers.get(IsHeadOfficeInUKPage) map {
    answer =>
      Row(
        key     = Key(msg"isHeadOfficeInUK.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.IsHeadOfficeInUKController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"isHeadOfficeInUK.checkYourAnswersLabel"))
          )
        )
      )
  }

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
        value   = Value(country(answer)),
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

  def whatIsHeadOfficeAddressUk: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressUkPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsHeadOfficeAddressUk.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(ukAddress(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsHeadOfficeAddressUkController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsHeadOfficeAddressUk.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsHeadOfficeAddressNonUk: Option[Row] = userAnswers.get(WhatIsHeadOfficeAddressNonUkPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsHeadOfficeAddressNonUk.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(nonUkAddress(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsHeadOfficeAddressNonUkController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsHeadOfficeAddressNonUk.checkYourAnswersLabel"))
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

  private def ukAddress(address: UkAddress): Content = {
    val result = s"${address.addressLineOne}, " +
      s"${address.addressLineTwo}, " +
      s"${address.addressLineThree.map(s => s"$s, ").getOrElse("")}" +
      s"${address.addressLineFour.map(s => s"$s, ").getOrElse("")}" +
      s"${address.postcode}"

    lit"$result"
  }
  private def nonUkAddress(address: NonUkAddress): Content = {
    val result = s"${address.addressLineOne}, " +
      s"${address.addressLineTwo}, " +
      s"${address.addressLineThree.map(s => s"$s, ").getOrElse("")}" +
      s"${address.addressLineFour.map(s => s"$s, ").getOrElse("")}" +
      s"${countryService.getCountryByCode(address.country).getOrElse("")}"

    lit"$result"
  }

  private def country(code: String): Content =
    lit"${countryString(code)}"

  private def countryString(code: String): String = s"${countryService.getCountryByCode(code).getOrElse("")}"

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
