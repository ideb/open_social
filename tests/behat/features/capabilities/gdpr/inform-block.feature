@api @gdpr @inform-block @DS-5586 @stability @stability-4
Feature: Give user consent
  Benefit: In order to give user consent
  Role: As a LU
  Goal/desire: I want to give user consent

  Scenario: Successfully give user consent

    Given users:
      | name               | mail                           | status | roles         |
      | behatadministrator | behatadministrator@example.com | 1      | administrator |
      | behatuser          | behatuser@example.com          | 1      |               |

    Given I enable the module "social_gdpr"

    Given I am logged in as "behatadministrator"
    When I am on "admin/structure/block"
    And I click "Place block"
    And I wait for AJAX to finish
    And I click the xth "4" element with the css ".block-add-table a"
    And I wait for AJAX to finish
    And I should see "Data Policy Inform" in the ".form-item-settings-admin-label" element
    # Press "Save block" button
    Then I select "Complementary top" from "Region"
    And I click the xth "0" element with the css ".ui-button.form-submit"
    When I am on "admin/config/system/inform-consent"
    Then I should see the heading "Data usage explanation" in the "Admin page title block" region
    And I should see the text "There is no Inform Block yet."
    When I click "Add page"
    Then I should be on "admin/config/system/inform-consent/add"
    And I should see checked the box "Enable on this page"
    And I should see "Title" in the ".form-item-label.form-type-textfield label.form-required" element
    And I should see "Page" in the ".form-item-page.form-type-textfield label.form-required" element
    And I should see "Summary" in the ".form-item-summary-value.form-type-textarea label.form-required" element
    And I should see "Description" in the ".form-item-body-value.form-type-textarea label:not(.form-required)" element
    When I fill in "Title" with "Inform block title for sign up page"
    And I fill in "Page" with "/user/register"
    And I fill in the "Summary" WYSIWYG editor with "Inform block summary for sign up page"
    And I fill in the "Description" WYSIWYG editor with "Inform block description for sign up page"
    And I press "Save"
    Then I should be on "admin/config/system/inform-consent/add"
    And I should see "Machine-readable name" in the ".form-item-id.form-type-machine-name label.form-required" element
    When I fill in "Machine-readable name" with "sign_up"
    And I press "Save"
    Then I should be on "admin/config/system/inform-consent"
    And I should see the text "Saved the Inform block title for sign up page Example."
    And I should not see the text "There is no Inform Block yet."
    And I should see the text "Inform block title for sign up page"
    And I should see the text "/user/register"
    And I should see the text "Yes"
    When I logout
    And I click "Sign up"
    Then I should see the heading "Inform block title for sign up page" in the "Sidebar second" region
    And I should see the text "Inform block summary for sign up page"
    And I should see the link "Read more"
    When I click "Read more"
    And I wait for AJAX to finish
    Then I should see "Inform block title for sign up page" in the ".ui-dialog-title" element
    And I should see "Inform block description for sign up page" in the ".ui-dialog-content p" element
    When I am logged in as "behatadministrator"
    And I am on "admin/config/system/inform-consent/add"
    And I fill in "Title" with "Inform block title for user edit page"
    And I fill in "Page" with "/user/*/edit"
    And I fill in the "Summary" WYSIWYG editor with "Inform block summary for user edit page"
    And I press "Save"
    And I fill in "Machine-readable name" with "user_edit"
    And I press "Save"
    And I am logged in as "behatuser"
    And I click "Profile of behatuser"
    And I click "Settings"
    Then I should see the heading "Inform block title for user edit page" in the "Sidebar second" region
    And I should see the text "Inform block summary for user edit page"
    And I should not see the link "Read more"
    When I am logged in as "behatadministrator"
    And I am on "admin/config/system/inform-consent/user_edit"
    And I uncheck the box "Enable on this page"
    And I press "Save"
    And I am logged in as "behatuser"
    And I click "Profile of behatuser"
    And I click "Settings"
    Then I should not see the text "Inform block title for user edit page"
    And I should not see the text "Inform block summary for user edit page"
