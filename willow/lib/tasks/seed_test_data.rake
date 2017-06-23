namespace :willow do
  desc 'Seeds test data, will read from specified file usage: willow:seed_test_data["seed_file.json"]'
  task :"seed_test_data", [:seedfile] => :environment do |task, args|

    seedfile = args.seedfile
    unless args.seedfile.present?
      seedfile = "/seed/demo.json"
    end

    if (File.exists?(seedfile))
      puts("Running seedfile: #{seedfile}")
    else
      abort("ERROR: missing seedfile: #{seedfile}")
    end

    seed = JSON.parse(File.read(seedfile))

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
    # Create administrative sets
    ######

    administrative_sets = {}
    if seed.has_key?("administrative_sets")
      seed["administrative_sets"].each do |administrative_set|
        arguments = {}
        administrative_set["metadata"].each do |key, val|
          arguments[key.to_sym] = val
        end

        as = AdminSet.where(id: administrative_set["id"]).first || AdminSet.create!(
          id: administrative_set["id"],
          **arguments)

        if administrative_set.has_key?("permission_template")
          pt = Sufia::PermissionTemplate
                   .where(admin_set_id: administrative_set["id"],
                          workflow_name: administrative_set["permission_template"]["workflow_name"])
                   .first_or_create!

          if administrative_set["permission_template"].has_key?("permission_template_access")
            administrative_set["permission_template"]["permission_template_access"].each do |pta|
              Sufia::PermissionTemplateAccess
                  .where(permission_template: pt,
                         agent_type: pta["agent_type"],
                         agent_id: pta["agent_id"],
                         access: pta["access"])
                  .first_or_create!
            end
          end
        end

        administrative_sets[administrative_set["id"]] = as
      end
    end

    # finished administrative sets
    ##############################################



    ##############################################
    # Configure workflow_responsabilities
    ######

    if seed.has_key?("workflow_responsibilities")
      seed["workflow_responsibilities"].each do |workflow_responsibility|
        user = User.where(email: workflow_responsibility["user_email"]).first
        agent = Sipity::Agent.where(proxy_for: user).first_or_create!
        workflow = Sipity::Workflow.where(name: workflow_responsibility["workflow_name"]).first
        role = Sipity::Role.where(name: workflow_responsibility["role_name"]).first
        workflow_role = Sipity::WorkflowRole.where(workflow: workflow, role: role).first

        if user.present? && agent.present? && workflow.present? && role.present? && workflow_role.present?
          Sipity::WorkflowResponsibility.where(agent: agent, workflow_role: workflow_role).first_or_create!
        else
          abort("Unable to create workflow_responsibility : user: #{user}, agent: #{agent}, workflow: #{workflow}, role: #{role}, workflow_role: #{workflow_role}")
        end
      end
    end

    # finished workflow_responsabilities
    ##############################################


    ##############################################
    # Create some collections
    ######

    cols = {}
    if seed.has_key?("collections")
      seed["collections"].each do |collection|
        arguments = {}
        collection["metadata"].each do |key, val|
          arguments[key.to_sym] = val
        end
        col = Collection.where(id: collection["id"]).first || Collection.create!(
            id: collection["id"],
            edit_users: [depositor],
            depositor: depositor.email,
            **arguments
        )
        cols[collection["id"]] = col
      end
    end

    # finished creating collections
    ##############################################

    ##############################################
    # Create some works
    ######

    if seed.has_key?("works")
      seed["works"].each do |work|
        arguments = {}
        work["metadata"].each do |key, val|
          arguments[key.to_sym] = val
        end

        # first create the work
        newWork = Work.where(id: work["id"]).first || Work.create!(
          id: work["id"],
          edit_users: [depositor],
          depositor: depositor.email,
          **arguments
        )

        # then add any files
        if work.has_key?("files")
          work["files"].each do |file|
            fargs = {}
            file["metadata"].each do |key, val|
              fargs[key.to_sym] = val
            end

            fileset_id = "#{newWork.id}-#{file['id']}"
            label = File.basename(file["path"])
            fileset = FileSet.where(id: fileset_id).first || FileSet.create!(
                id: fileset_id,
                label: label,
                title: ["Fileset #{fileset_id} - #{label}"],
                edit_users: [depositor],
                depositor: depositor.email,
                **fargs
            )

            unless newWork.members.include?(fileset)
              # NB ordered_members is important here; members will not appear in blacklight!
              newWork.ordered_members << fileset
              fileset.save!
            end

            unless fileset.files.any?
              Hydra::Works::UploadFileToFileSet.call(fileset, open(file["path"]))
              CreateDerivativesJob.perform_now(fileset, fileset.files.first.id)
            end

            unless newWork.representative_id.present?
              newWork.representative_id = fileset.id
              newWork.thumbnail_id = fileset.thumbnail_id
              newWork.save!
            end
          end
        end

        # then add to any collections
        if work.has_key?("collections")
          work["collections"].each do |collection_id|
            collection = cols[collection_id]
            unless collection.members.include?(newWork)
              collection.ordered_members << newWork
              collection.save!
            end
          end
        end

        # feature the work if requested
        if work.has_key?("featured") && work["featured"] == true
          FeaturedWork.where(work_id: work["id"]).first_or_create!
        end

        newWork.save!

        break # TODO: REMOVE THIS LINE
      end
    end

    # finished creating works
    ##############################################

  end
end