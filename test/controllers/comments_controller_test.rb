require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as :kevin
  end

  test "create" do
    assert_difference "bubbles(:logo).comments.count", +1 do
      post bucket_bubble_comments_url(buckets(:writebook), bubbles(:logo), params: { comment: { body: "Agreed." } })
    end

    assert_redirected_to bucket_bubble_url(buckets(:writebook), bubbles(:logo))
  end
end
