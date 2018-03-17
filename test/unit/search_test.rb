require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  def setup
    do_cleanup
  end

  test 'folder should be provided' do
    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test'})

    assert_equal result.success?, false
    assert_equal result['contract.default'].errors.messages[:folder_id].first, "can't be blank"
  end

  test 'term should be provided and have at least 3 characters' do
    folder = create(:folder)

    result = Boxroom::Search::FilesAndFolders.(params: {folder_id: folder.id})
    assert_equal result.success?, false
    assert_equal result['contract.default'].errors.messages[:term].last, 'is too short (minimum is 3 characters)'

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'te', folder_id: folder.id})
    assert_equal result.success?, false
    assert_equal result['contract.default'].errors.messages[:term].last, 'is too short (minimum is 3 characters)'

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: folder.id})
    assert_equal result.success?, true
  end

  test 'should find folders' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    2.times { create(:folder) }

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal result.success?, true
    assert_equal result['folders'].size, 2
  end

  test 'should find files' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    2.times { create(:user_file) }

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal result.success?, true
    assert_equal result['files'].size, 2
  end

  test 'should search in subfolders' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    subfolder = create(:folder)

    2.times { create(:folder, parent: subfolder) }
    2.times { create(:user_file, folder: subfolder) }

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal result.success?, true
    assert_equal result['folders'].size, 3
    assert_equal result['files'].size, 2
  end
end