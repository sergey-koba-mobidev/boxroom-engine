require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  def setup
    do_cleanup
  end

  test 'folder should be provided' do
    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test'})

    assert_equal false, result.success?
    assert_equal "can't be blank", result['contract.default'].errors.messages[:folder_id].first
  end

  test 'term should be provided and have at least 3 characters' do
    folder = create(:folder)

    result = Boxroom::Search::FilesAndFolders.(params: {folder_id: folder.id})
    assert_equal false, result.success?
    assert_equal 'is too short (minimum is 3 characters)', result['contract.default'].errors.messages[:term].last

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'te', folder_id: folder.id})
    assert_equal false, result.success?
    assert_equal 'is too short (minimum is 3 characters)', result['contract.default'].errors.messages[:term].last

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: folder.id})
    assert_equal true, result.success?
  end

  test 'should find folders' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    2.times {create(:folder)}

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal true, result.success?
    assert_equal 2, result['folders'].size
  end

  test 'should find files' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    2.times {create(:user_file)}

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal true, result.success?
    assert_equal 2, result['files'].size
  end

  test 'should search in subfolders' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    subfolder = create(:folder)

    2.times {create(:folder, parent: subfolder)}
    2.times {create(:user_file, folder: subfolder)}

    result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id})
    assert_equal true, result.success?
    assert_equal 3, result['folders'].size
    assert_equal 2, result['files'].size
  end

  test 'should sort folders' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    create(:folder, name: 'test0')
    create(:folder, name: 'test1')

    sort_fields = %w(name date size)
    sort_fields.each do |sort_field|
      result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id, sort_field: sort_field, sort_dir: 'desc'})
      assert_equal true, result.success?
      assert_equal 2, result['folders'].size
      assert_equal sort_field == 'size' ? 'test0' : 'test1', result['folders'][0].name
      assert_equal sort_field == 'size' ? 'test1' : 'test0', result['folders'][1].name
    end
  end

  test 'should sort files' do
    root = create(:folder, :name => 'Root folder', :parent => nil) # Root folder
    create(:user_file, attachment_file_name: 'test0', attachment_file_size: 1)
    create(:user_file, attachment_file_name: 'test1', attachment_file_size: 2)

    sort_fields = %w(name date size)
    sort_fields.each do |sort_field|
      result = Boxroom::Search::FilesAndFolders.(params: {term: 'test', folder_id: root.id, sort_field: sort_field, sort_dir: 'desc'})
      assert_equal true, result.success?
      assert_equal 2, result['files'].size
      assert_equal 'test1', result['files'][0].attachment_file_name
      assert_equal 'test0', result['files'][1].attachment_file_name
    end
  end
end