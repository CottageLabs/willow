namespace :willow do
  desc 'Imports a JISC RDSS S3 bucket into Willow usage: willow:import["region","bucket"]'
  task :"import", [:region,:bucket,:prefix] => :environment do |task, args|
    
    args.with_defaults(:prefix => '/')

    bucket = args.bucket
    region = args.region
    prefix = args.prefix

    import_folder = ENV['IMPORT_FOLDER'] || 'tmp/importer'
    import_filter = ENV['IMPORT_FILTER'] || nil
    import_user = ENV['IMPORT_USER'] || ENV['BATCH_USER'] || nil
    import_collection_id = ENV['IMPORT_COLLECTION_ID'] || nil
    import_visibility = ENV['IMPORT_VISIBILITY'] || 'open'


    puts "Task to import JISC RDSS data from an S3 bucket into Willow"
    puts " REQUIRED SETTINGS:"
    puts "   Region: #{region}"
    puts "   Bucket: #{bucket}"
    puts "   Prefix: #{prefix}"

    puts " OPTIONAL SETTINGS (via ENV variables):"
    puts "   Temporary import folder (IMPORT_FOLDER): #{import_folder}"
    puts "   Bucket filter (IMPORT_FILTER): #{import_filter}"
    puts "   Importing user (IMPORT_USER): #{import_user}"
    puts "   Collection_id (IMPORT_COLLECTION_ID): #{import_collection_id}"
    puts "   Visibility (IMPORT_VISIBILITY): #{import_visibility}"


    importer = DataImporter::Importer.new(bucket: bucket, region: region, prefix: prefix,
                                          import_folder: import_folder, import_filter: import_filter,
                                          import_user: import_user, import_collection_id: import_collection_id,
                                          import_visibility: import_visibility)

    importer.sync_with_s3()

    importer.import_into_willow()

    puts "All done!"

  end
end
