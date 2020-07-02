require 'test_helper'
# unique(testiranje na edna celina primer eden model) i integration testing(end to end testing od wiew do model sve step by step se
#testira)
class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_index_url
    assert_response :success
  end

end
