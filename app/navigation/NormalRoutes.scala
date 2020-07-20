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

package navigation

import controllers.routes
import models.{NormalMode, UserAnswers}
import pages.{AboutThisSectionPage, CheckYourAnswersPage, DoNonEEAOrgsHaveControllingInterestPage, IndexPage, IsHeadOfficeInUKPage, IsTheCompanyStillPartOfTheTrustPage, IsTheGoverningCountryKnownPage, IsTheHeadOfficeLocationKnownPage, Page, WhatIsHeadOfficeAddressNonUkPage, WhatIsHeadOfficeAddressUkPage, WhatIsTheCompanyNamePage, WhatIsTheGoverningCountryPage, WhenDidTheCompanyBecomePartOfTheTrustPage, WhenDidTheCompanyLeaveTheTrustPage}
import play.api.mvc.Call

object NormalRoutes {
  val routeMap: Page => UserAnswers => Call = {
    case IndexPage                                    => _ => routes.AboutThisSectionController.onPageLoad()
    case AboutThisSectionPage                         => _ => routes.DoNonEEAOrgsHaveControllingInterestController.onPageLoad(NormalMode)
    case DoNonEEAOrgsHaveControllingInterestPage      => _ => routes.WhatIsTheCompanyNameController.onPageLoad(NormalMode)
    case WhatIsTheCompanyNamePage                     => _ => routes.IsTheHeadOfficeLocationKnownController.onPageLoad(NormalMode)
    case IsTheHeadOfficeLocationKnownPage             => _ => routes.IsHeadOfficeInUKController.onPageLoad(NormalMode)
    case IsHeadOfficeInUKPage                         => _ => routes.WhatIsHeadOfficeAddressNonUkController.onPageLoad(NormalMode)
    case WhatIsHeadOfficeAddressNonUkPage             => _ => routes.WhatIsHeadOfficeAddressUkController.onPageLoad(NormalMode)
    case WhatIsHeadOfficeAddressUkPage                => _ => routes.IsTheGoverningCountryKnownController.onPageLoad(NormalMode)
    case IsTheGoverningCountryKnownPage               => _ => routes.WhatIsTheGoverningCountryController.onPageLoad(NormalMode)
    case WhatIsTheGoverningCountryPage                => _ => routes.WhenDidTheCompanyBecomePartOfTheTrustController.onPageLoad(NormalMode)
    case WhenDidTheCompanyBecomePartOfTheTrustPage    => _ => routes.IsTheCompanyStillPartOfTheTrustController.onPageLoad(NormalMode)
    case IsTheCompanyStillPartOfTheTrustPage          => _ => routes.WhenDidTheCompanyLeaveTheTrustController.onPageLoad(NormalMode)
    case WhenDidTheCompanyLeaveTheTrustPage           => _ => routes.CheckYourAnswersController.onPageLoad()
    case CheckYourAnswersPage                         => _ => routes.DoYouWantToAddAnotherNonEEAOrganisationController.onPageLoad(NormalMode);
    case _                                            => _ => routes.IndexController.onPageLoad()
  }
}
