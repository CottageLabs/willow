require 'support/jisc_rdss_schemas'

# NB: these tests require some files which cannot be committed to git (yet)
# In order to successfully run them, ensure the path "/willow/spec/fixtures/files/schemas/jisc_rdss/*" is in your
# .gitignore file.
#
# Then, copy the following files and folders to the given locations:
# *  https://github.com/JiscRDSS/rdss-message-api-docs/tree/master/messages  => willow/willow/spec/fixtures/files/schemas/jisc_rdss/messages
# *  https://github.com/JiscRDSS/rdss-message-api-docs/tree/master/schemas   => willow/willow/spec/fixtures/files/schemas/jisc_rdss/schemas
#
# Be sure that the files above are not committed to git!


RSpec.describe "JISC RDSS examples" do

  before(:all) do
    @validator = load_validator_with_jisc_rdss_schemas()
  end

  context "metadata" do
    it 'create_request' do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/create/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/metadata/create/request.json").read)).to be_empty
    end

    it 'update_request' do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/update/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/metadata/update/request.json").read)).to be_empty
    end

    it 'delete_request' do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/delete/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/metadata/delete/request.json").read)).to be_empty
    end

    it 'read_request' do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/read/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/metadata/read/request.json").read)).to be_empty
    end

    it 'read_response' do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/read/response_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/metadata/read/response.json").read)).to be_empty
    end
  end

  context "vocabulary" do
    it "patch_request" do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/vocabulary/patch/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/vocabulary/patch/request.json").read)).to be_empty
    end

    it "read_request" do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/vocabulary/read/request_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/vocabulary/read/request.json").read)).to be_empty
    end

    it "read_response" do
      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/vocabulary/read/response_schema.json").read,
          file_fixture("schemas/jisc_rdss/messages/vocabulary/read/response.json").read)).to be_empty
    end
  end

end
