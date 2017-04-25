namespace :willow do
  desc "Reindex Willow test data (do not run on production!)"
  task :"reindex_test_data" => :environment do

    # setup logging
    log = ActiveSupport::Logger.new(STDOUT)

    # Wipe the Solr index - it should be empty anyway
    log.info('Wiping the Solr index')
    ActiveFedora::SolrService.instance.conn.delete_by_query('*:*', params: { 'softCommit' => true })

    # optimise the Solr index, so it is in a healthy state prior to reindexing
    log.info('Optimising the Solr index')
    ActiveFedora::SolrService.instance.conn.optimize()

    # now reindex to Solr
    log.info('Generating a list of Fedora objects to index')
    items = ActiveFedora::Base.descendant_uris(ActiveFedora.fedora.base_uri)
    items.shift # discard the first item

    log.info("First pass of reindex (#{items.count} objects)")
    items.each_with_index do |uri, i|
      log.debug("Indexing: #{uri}")
      obj = ActiveFedora::Base.find(ActiveFedora::Base.uri_to_id(uri))
      obj.update_index

      if i % 100 == 0
        log.info("Re-optimising Solr index")
        ActiveFedora::SolrService.instance.conn.optimize()
      end
    end

    # There is a bug in Sufia 7.3 (and below) in that the re-indexing process assumes that the access/permissions exist
    # in Solr before the reindex starts. But if we are reindexing to a blank Solr (e.g. after a new install + fedora
    # restore), then there are no permissions: in this case, items are restored to Solr with an incomplete set of
    # permissions, leading to apparent missing data in Sufia. A work-around is to run the reindex again, as on the 2nd
    # attempt all the permission objects will exist. A better approach would be to restore the permissions objects
    # before restoring the data objects... but we'll leave that for a a rainy day.

    log.info("Second pass of reindex (#{items.count} objects)")
    items.each_with_index do |uri, i|
      log.debug("Indexing: #{uri}")
      obj = ActiveFedora::Base.find(ActiveFedora::Base.uri_to_id(uri))

      # Unfortunately, we also need to re-create the derivatives, otherwise restored images will not have thumbnails.
      # So lets do it the hard way by downloading the original from Fedora and re-processing it.
      if obj.is_a? FileSet
        if obj.original_file.present?
          file = obj.original_file
        elsif obj.files.present?
          file = obj.files.first
        else
          file = nil
        end

        if file.present?
          tempfile = open(file.uri)
          CreateDerivativesJob.perform_now(obj, file.id, tempfile)
          tempfile.close()
        end
      end

      # TODO: this does not work reliably enough and only some derivatives are regenerated. Find a better method.
      # if obj.respond_to?(:thumbnail) && obj.thumbnail.present? && obj.thumbnail.original_file.present?
      #   thumbnail = open(obj.thumbnail.uri.to_s)
      #   obj.thumbnail.create_derivatives(thumbnail.path)
      #   obj.thumbnail.update_index
      #   thumbnail.close
      # end

      obj.update_index
      if i % 100 == 0
        log.info("Re-optimising Solr index")
        ActiveFedora::SolrService.instance.conn.optimize()
      end
    end

    # optimise the Solr index again
    log.info("Re-optimising Solr index")
    ActiveFedora::SolrService.instance.conn.optimize()

    # Solr will crash with a Java stack-overflow error if you rebuild suggestions. Suspect a bug in the Solr FuzzyLookupFactory, disabling for now.
    # puts "Rebuilding suggestions..."
    # ActiveFedora::SolrService.instance.conn.suggest({:data => "suggest.build=true", :method => :post})

    log.info("Reindexing completed, there are #{ActiveFedora::SolrService.count("*:*")} object(s) in Solr")
  end
end