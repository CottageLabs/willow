namespace :willow do
  desc 'Seeds test data, usage: willow:seed_test_data["email@example.com", "password", "name"]'
  task :"seed_test_data", [:email, :password, :name] => :environment do |task, args|
    email = args.email
    password = args.password
    name = args.name

    unless email.present?
      email = "admin@willow"
      Rails.logger.warn("Email not provided, using default: #{email}")
    end

    unless password.present?
      password = "password"
      Rails.logger.warn("Password not provided, using default: #{password}")
    end

    unless name.present?
      name = "Willow Admin"
      Rails.logger.warn("Name not provided, using default: #{name}")
    end

    # As a general principal for this seed data, use fixed IDs and first_or_create to prevent duplicates if running multiple times
    user = User.where(email: email).first_or_create!(password: password, display_name: name)

    # use the example files in the lib/assets folder
    example_files = Dir["lib/assets/example*"]

    for collection_id in 1..3
      collection = Collection.where(id: "collection-#{collection_id}").first || Collection.create!(
          id: "collection-#{collection_id}",
          title: ["Willow Journal of Collection #{collection_id}"],
          resource_type: ["Journal"],
          creator: [ ["Bloggs, Joesphina", "Smith, Bob", "Jones, Frederick"][collection_id % 3] ],
          description: ["This is a collection of articles from the Willow Journal of Collection #{collection_id}"],
          keyword: ["willow", "journal", "collection #{collection_id}"],
          rights: ["http://www.europeana.eu/portal/rights/rr-r.html"],
          publisher: ["Willow Publishing Group"],
          date_created: ["200#{collection_id}-0#{collection_id}-0#{collection_id}"],
          subject: ["willow journal"],
          language: ["English"],
          based_near: ["UK"],
          edit_users: [user],
          visibility: "open",
          depositor: user.email
      )

      for work_id in 1..10
        work = Work.where(id: "work-#{collection_id}-#{work_id}").first || Work.create!(
          id: "work-#{collection_id}-#{work_id}",
          title: ["Article #{collection_id}-#{work_id}"],
          resource_type: ["Article"],
          creator: ["Author#{work_id}"],
          contributor: ["Contributor#{work_id % 3}"],
          description: ["Article #{work_id} in the #{collection.title.first}"],
          keyword: ["article #{work_id}"],
          rights: ["http://creativecommons.org/publicdomain/zero/1.0/"],
          publisher: [["Willow Publishing Group", "Blue Skies Publishing"][work_id % 2]],
          date_created: ["2017-0#{collection_id}-#{work_id}"],
          subject: ["willow article"],
          language: ["English"],
          based_near: [["London", "Cardiff", "Oxford", "Tring", "Edinburgh", "Monte Carlo"][work_id % 6]],
          edit_users: [user],
          visibility: "open",
          depositor: user.email
        )


        example_file = example_files[work_id % example_files.count]
        fileset = FileSet.where(id: "fileset-#{collection_id}-#{work_id}").first || FileSet.create!(
          id: "fileset-#{collection_id}-#{work_id}",
          label: File.basename(example_file),
          title: ["Fileset #{collection_id}-#{work_id} - #{File.basename(example_file)}"],
          edit_users: [user],
          visibility: "open",
          depositor: user.email
        )


        unless collection.members.include?(work)
          collection.ordered_members << work
          collection.save!
        end

        unless work.members.include?(fileset)
          # NB ordered_members is important here; members will not appear in blacklight!
          work.ordered_members << fileset
          fileset.save!
        end

        unless fileset.files.any?
          Hydra::Works::UploadFileToFileSet.call(fileset, open(example_file))
          CreateDerivativesJob.perform_now(fileset, fileset.files.first.id)
        end

        unless work.representative_id.present?
          work.representative_id = fileset.id
          work.thumbnail_id = fileset.thumbnail_id
          work.save!
        end


      end

    #
    #
    #
    #
    #
    end

  end
end
