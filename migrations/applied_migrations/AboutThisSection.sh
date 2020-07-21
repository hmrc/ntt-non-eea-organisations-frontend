#!/bin/bash

echo ""
echo "Applying migration AboutThisSection"

echo "Adding routes to conf/app.routes"
echo "" >> ../conf/app.routes
echo "GET        /aboutThisSection                       controllers.AboutThisSectionController.onPageLoad()" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "aboutThisSection.title = aboutThisSection" >> ../conf/messages.en
echo "aboutThisSection.heading = aboutThisSection" >> ../conf/messages.en

echo "Migration AboutThisSection completed"
