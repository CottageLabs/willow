This structure contains all of the available root messages and enumerations for each version of the schema used in 
validations. The roots are taken from versions from tagged releases which are mapped to directories in this structure:

https://github.com/JiscRDSS/rdss-message-api-specification/tree/%semver%/messages/body/metadata/%event%/request_schema.json

where %semver% is the tag and %event% is the type of CRUD event the request schema is for:

For example:

https://github.com/JiscRDSS/rdss-message-api-specification/tree/2.0.0/messages/body/metadata/create/request_schema.json

is for the create event of version 2.0.0 of the schema.

Note that the current link, links to the latest release of the schema version and will be used for all enumerations
of the applications, whereas messages will link to the tagged version and only default to current if the tag is not
supplied.