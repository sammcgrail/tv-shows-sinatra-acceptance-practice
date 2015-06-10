require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.


    scenario "successfully add a new show" do
      visit "/television_shows/new"
      fill_in 'Title:', with: "A Test Show"
      fill_in 'Network:', with: "A Test Network"
      fill_in 'Starting Year:', with: "1990"
      fill_in 'Ending Year:', with: "1996"
      find(:select, 'genre').find(:option, 'Action').select_option
      fill_in 'Synopsis:', with: "A Test Synopsis"
      click_button 'Add TV Show'
      expect(page).to have_content('TV Shows')
      expect(page).to have_content('A Test Show')
      expect(page).to have_content('A Test Network')
      click_link 'A Test Show (A Test Network)'

      expect(page).to have_content('A Test Show')
      expect(page).to have_content('A Test Network')
      expect(page).to have_content('1990 - 1996')
      expect(page).to have_content('Action')
      expect(page).to have_content('A Test Synopsis')
    end

    scenario "fail to add a show with invalid information" do
      visit "/television_shows/new"
      click_button 'Add TV Show'

      expect(page).to have_content('Add Show')
    end


  end
