namespace :willow do
  desc 'Seeds test data, will read from specified file usage: willow:seed_test_data["seed_file.json"]'
  task :"seed_test_data", [:seedfile] => :environment do |task, args|

    seedfile = args.seedfile
    unless args.seedfile.present?
      seedfile = "/seed/demo.json"
    end

    file = open(seedfile)
    json = file.read
    seed = JSON.parse(json)

    ##############################################
    # make the requested users
    ######

    depositor = false
    admin = Role.where(name: "admin").first_or_create!
    seed["users"].each do |user|
      newUser = User.where(email: user["email"]).first_or_create!(password: user["password"], display_name: user["name"])

      if user["role"] == "admin"
        unless admin.users.include?(newUser)
          admin.users << newUser
          admin.save!
        end
      end

      if user.has_key?("depositor")
        depositor = newUser
      end
    end

    # finished creating users
    ##############################################

    ##############################################
    # populate the site text
    ######

    seed["site_text"].each do |key, array|
      html = array.join("")
      if key == "marketing"
        marketing_text = ContentBlock.where(name: "marketing_text").first_or_create!
        marketing_text.value=html
        marketing_text.save!
      elsif key == "about"
        about_page = ContentBlock.where(name: "about_page").first_or_create!
        about_page.value=html
        about_page.save!
      end
    end

    # finished populating site text
    ##############################################

    ##############################################
    # Create some collections
    ######

    seed["collections"].each do |collection|
      col = Collection.where(id: collection["id"]).first || Collection.create!(
          id: collection["id"],
          title: collection["title"],
          resource_type: collection["resource_type"],
          creator: collection["creator"],
          description: collection["description"],
          keyword: collection["keyword"],
          rights: collection["rights"],
          publisher: collection["publisher"],
          date_created: collection["date_created"],
          subject: collection["subject"],
          language: collection["language"],
          based_near: collection["based_near"],
          visibility: "open",
          edit_users: [depositor],
          depositor: depositor.email
      )
      col.save!
    end

    # finished creating collections
    ##############################################

  end
end