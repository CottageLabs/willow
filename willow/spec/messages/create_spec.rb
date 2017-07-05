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


RSpec.describe "create_request" do

  before(:all) do
    @validator = load_validator_with_jisc_rdss_schemas()
  end

  it 'validates against the schema' do

    skip "Comming soon"

    # expect(@validator.fully_validate(
    #     file_fixture("schemas/jisc_rdss/messages/metadata/create/request_schema.json").read,
    #     file_fixture("schemas/jisc_rdss/messages/metadata/create/request.json").read)).to be_empty


  end

end
