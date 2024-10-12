require "test_helper"

class BubbleTest < ActiveSupport::TestCase
  setup do
    Current.user = users(:kevin)
  end

  test "boosting" do
    assert_difference %w[ bubbles(:logo).boost_count bubbles(:logo).events.count ], +1 do
      bubbles(:logo).boost!
    end
  end

  test "commenting" do
    bubbles(:logo).comment! "Agreed."

    assert_equal "Agreed.", bubbles(:logo).comments.last.body
  end

  test "assigning" do
    bubbles(:logo).assign users(:david)

    assert_equal users(:kevin, :jz, :david), bubbles(:logo).assignees
    assert_equal users(:david, :kevin), bubbles(:logo).assigners.uniq
    assert_equal [ users(:david).id ], bubbles(:logo).events.last.assignee_ids
    assert_equal [ "David" ], bubbles(:logo).events.last.assignee_names
  end

  test "searchable by title" do
    bubble = buckets(:writebook).bubbles.create! title: "Insufficient haggis", creator: users(:kevin)

    assert_includes Bubble.search("haggis"), bubble
  end

  test "mentioning" do
    bubble = buckets(:writebook).bubbles.create! title: "Insufficient haggis", creator: users(:kevin)
    bubbles(:logo).comments.create! body: "I hate haggis", creator: users(:kevin)
    bubbles(:text).comments.create! body: "I love haggis", creator: users(:kevin)

    assert_equal [ bubble, bubbles(:logo), bubbles(:text) ].sort, Bubble.mentioning("haggis").sort
  end
end
