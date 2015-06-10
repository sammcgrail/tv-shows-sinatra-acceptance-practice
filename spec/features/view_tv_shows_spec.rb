require "spec_helper"

feature "user views list of TV shows" do
  # As a TV fanatic
  # I want to view a list of TV shows
  # So I can find new shows to watch
  #
  # Acceptance Criteria:
  # * I can see the names and networks of all TV shows

  let(:game_of_thrones) {TelevisionShow.create!({
      title: "Game of Thrones", network: "HBO",
      starting_year: 2011, genre: "Fantasy"
    })}
  let(:married_with_children) {TelevisionShow.create!({
      title: "Married... with Children", network: "Fox",
      starting_year: 1987, ending_year: 1997,
      genre: "Comedy"
    })}

  scenario "view list of TV shows" do
    # The user visits the index page
    game_of_thrones
    married_with_children
    visit "/television_shows"
    # And should see both TV shows listed (just the title and network)
    expect(page).to have_content("Game of Thrones (HBO)")
    expect(page).to have_content("Married... with Children (Fox)")
  end
  # As a TV fanatic
  # I want to view the details for a TV show
  # So I can find learn more about it

  # Acceptance Criteria:
  # * I can see the title, network, start and end year, genre, and synopsis
  #   for a show.
  # * If the end year is not provided it should indicate that the show is still
  #   running.
  scenario "view details for a TV show" do
    game_of_thrones
    married_with_children
    visit '/television_shows'
    click_on 'Game of Thrones (HBO)'
    expect(page).to have_content("Fantasy")
    expect(page).to have_content("2011")
  end
  scenario "view details for a TV show with missing information" do
    game_of_thrones
    married_with_children
    visit '/television_shows'
    click_on 'Game of Thrones (HBO)'
    expect(page).to_not have_content("Synopsis")
  end
end
