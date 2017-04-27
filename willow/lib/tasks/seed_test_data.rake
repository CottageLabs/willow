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

    admin = Role.where(name: "admin").first_or_create!

    user = User.where(email: email).first_or_create!(password: password, display_name: name)

    unless admin.users.include?(user)
      admin.users << user
      admin.save!
    end

    marketing_text = ContentBlock.where(name: "marketing_text").first_or_create!
    unless marketing_text.value.present?
      marketing_text.value="<div style=\"font-size: 0.5em; padding: 1em; \"><p>Cottage Labs is pleased to offer repository solutions using cutting-edge open source technology <a href=\"https://projecthydra.org/\">Hydra</a> and <a href=\"http://fedorarepository.org/\">Fedora</a>. We can help you from initial requirements, through customisation and integration with your systems, to long term support and maintenance.</p>
        <p>Whether you are a small institution looking to get the essential features out-of-the-box, or a large, research-intensive organisation looking for customisations and integration with local systems, don't hesitate to&nbsp;<a href=\"mailto:willow@cottagelabs.com\">contact us</a> to find out what we can do for you.</p>
        <p>Read more about <a href=\"https://cottagelabs.com/willow\">Willow</a> on our website or take a look around this demo system.</p></div>"
      marketing_text.save!
    end

    about_page = ContentBlock.where(name: "about_page").first_or_create!
    unless about_page.value.present?
      about_page.value="<p>We have a set of components from the Hydra ecosystem that we support, and we will:</p>
        <ul>
        <li>Help you understand your requirements, model your data, and plan your repository system around you</li>
        <li>Host and maintain everything for you, as your fully featured repository system</li>
        <li>Support, maintain and extend your existing system, if you prefer</li>
        <li>Get you migrated from any legacy systems in place</li>
        <li>Do bespoke development, and help you get integrated with 3rd party systems</li>
        </ul>
        <p>We can join you at any stage of your existing project, including:</p>
        <ul>
        <li>Initial requirements capture and analysis</li>
        <li>Data modelling and system architecture</li>
        <li>Implementation and deployment of the software stack</li>
        <li>Bespoke development, creating or customising existing components</li>
        <li>3rd party system integration - authentication, deposit environments, CRIS and CMS</li>
        <li>Maintenance, upgrades and migrations</li>
        </ul>
        <p>Our developers have many years experience in the repository, research data management and research information space, and will bring that to your project.</p>
        <p>Read more about&nbsp;<a href=\"https://cottagelabs.com/willow\">Willow</a>&nbsp;on our website or take a look around this demo system.</p>
        <h2>About this demo</h2>
        <p>The site you're looking at right now is built with&nbsp;<a href=\"http://sufia.io/\">Sufia</a>, a repository front-end which leverages the full power of&nbsp;<a href=\"https://projecthydra.org/\">Hydra</a>.</p>
        <p>Sufia supports functionality such as:</p>
        <ul>
        <li>Deposit and deposit workflows</li>
        <li>Access controls</li>
        <li>User profiles</li>
        <li>Collection and file management</li>
        <li>Batch editing</li>
        <li>Faceted search and browse</li>
        <li>Preservation functions</li>
        <li>... and much more; head over to their&nbsp;<a href=\"http://sufia.io/\">website</a>&nbsp;to learn more</li>
        </ul>
        <p>As we expand the components that form part of Willow, we'll add more to this demonstrator, so you can keep up to date with what's available.</p>"
      about_page.save!
    end

    # use the example files in the lib/assets folder
    example_files = Dir["lib/assets/example*"]

    for collection_id in (2).downto(1) # count backwards as it looks nicer in Sufia
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

      for work_id in (8).downto(1) # count backwards as it looks nicer in Sufia
        work = Work.where(id: "work-#{collection_id}-#{work_id}").first || Work.create!(
          id: "work-#{collection_id}-#{work_id}",
          title: ["Article #{collection_id}-#{work_id}"],
          resource_type: ["Article"],
          creator: ["Author #{(work_id % 3)+1}"],
          contributor: ["Contributor #{(work_id % 3)+1}"],
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


        # feature a few select works
        if work_id == collection_id
          FeaturedWork.where(work_id: work.id).first_or_create!
        end

      end # work
    end # controller

  end
end
