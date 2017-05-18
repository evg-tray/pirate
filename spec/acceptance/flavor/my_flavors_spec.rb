require_relative '../acceptance_helper'

feature 'Add flavors to user`s list', %q{
  In order to be able to search recipes with my set of flavors
  As a user
  I want to be able to add flavors in my set
} do

  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:flavors) { create_list(:flavor, 3) }
  given!(:user_flavors1) { create(:user_flavor, user: user, flavor: flavors[0]) }
  given!(:user_flavors2) { create(:user_flavor, user: user, flavor: flavors[1]) }

  scenario 'User view his flavors' do
    sign_in(user)
    visit my_flavors_path
    within '#my_flavor_list' do
      expect(page).to have_content user_flavors1.flavor.name
      expect(page).to have_content user_flavors2.flavor.name
    end
  end

  scenario 'User adds a flavor to his set from select list', js: true do
    sign_in(user)
    visit my_flavors_path

    select2(flavors[2].name, 'flavor_id')

    click_on t('flavors.my_flavors.add')
    within '#my_flavor_list' do
      expect(page).to have_content flavors[2].name
    end
  end

  scenario 'User change availability a flavor', js: true do
    sign_in(user)
    visit my_flavors_path

    within "#my_flavor_list #my_flavor-#{user_flavors1.id}" do
      click_on t('flavors.availability.ended')
      expect(page).to have_content t('flavors.availability.not_available')
      expect(page).to have_content t('flavors.availability.appeared')
      click_on t('flavors.availability.appeared')
      expect(page).to have_content t('flavors.availability.available')
      expect(page).to have_content t('flavors.availability.ended')
    end
  end

  scenario 'User delete a flavor from his set', js: true do
    sign_in(user)
    visit my_flavors_path

    within "#my_flavor_list #my_flavor-#{user_flavors1.id}" do
      click_on t('flavors.flavor.delete_my_flavor')
    end
    within "#my_flavor_list" do
      expect(page).not_to have_content user_flavors1.flavor.name
    end
  end

  scenario 'User does not see another user`s flavors' do
    sign_in(another_user)
    visit my_flavors_path

    within '#my_flavor_list' do
      expect(page).not_to have_content flavors[0].name
      expect(page).not_to have_content flavors[1].name
    end
  end
end
