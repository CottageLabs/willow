namespace :willow do
  desc 'Imports a JISC RDSS S3 bucket into Willow usage: willow:import["region","bucket"]'
  task :"import", [:region,:bucket] => :environment do |task, args|

    bucket = args.bucket
    region = args.region

    import_folder = ENV['IMPORT_FOLDER'] || 'tmp/importer'
    import_filter = ENV['IMPORT_FILTER'] || nil
    import_user = ENV['IMPORT_USER'] || nil
    import_collection_id = ENV['IMPORT_COLLECTION_ID'] || nil




    puts "Task to import JISC RDSS data from an S3 bucket into Willow"
    puts " REQUIRED SETTINGS:"
    puts "   Region: #{region}"
    puts "   Bucket: #{bucket}"

    puts " OPTIONAL SETTINGS (via ENV variables):"
    puts "   Temporary import folder (IMPORT_FOLDER): #{import_folder}"
    puts "   Bucket filter (IMPORT_FILTER): #{import_filter}"
    puts "   Importing user (IMPORT_USER): #{import_user}"
    puts "   Collection_id (IMPORT_COLLECTION_ID): #{import_collection_id}"


    importer = DataImporter::Importer.new(bucket: bucket, region: region,
                                          import_dir: import_folder, filter: import_filter,
                                          collection_id: import_collection_id, importing_user_email: import_user)

    importer.sync_with_s3()

    importer.import_into_willow()

    puts "All done!"

  end
end
