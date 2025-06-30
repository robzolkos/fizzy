require "test_helper"

class Command::Parser::ContextTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  setup do
    @user = users(:david)

    Card.find_each(&:reindex)
    Comment.find_each(&:reindex)
  end

  test "viewing a single card" do
    context = Command::Parser::Context.new(@user, url: card_path(cards(:layout)))

    assert context.viewing_card_contents?
    assert_not context.viewing_list_of_cards?

    assert_equal 1, context.cards.count
    assert_equal cards(:layout).id, context.cards.first.id
  end

  test "viewing cards index" do
    context = Command::Parser::Context.new(@user, url: cards_path)

    assert context.viewing_list_of_cards?
    assert_not context.viewing_card_contents?

    assert_equal @user.filters.from_params(FilterScoped::DEFAULT_PARAMS).cards.published.count, context.cards.count
  end

  test "viewing search results" do
    context = Command::Parser::Context.new(@user, url: search_path(q: "layout"))

    assert context.viewing_list_of_cards?
    assert_not context.viewing_card_contents?

    expected_cards = @user.accessible_cards.where(id: @user.search("layout").select(:card_id))

    assert_equal expected_cards.count, context.cards.count
    assert_equal expected_cards.pluck(:id).sort, context.cards.pluck(:id).sort
  end

  test "unrecognized URL pattern" do
    context = Command::Parser::Context.new(@user, url: filters_path)

    assert_not context.viewing_card_contents?
    assert_not context.viewing_list_of_cards?

    assert_empty context.cards
  end
end
