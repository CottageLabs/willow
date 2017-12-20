# Overriding the default terms and conditions text in hyrax gems ContentBlock
# The default text in the hyrax gem is hard coded and contains references to US legal terms and conditions
# the default text returned is the result of running the erb engine on our local version of 
# app/views/hyrax/content_blocks
ContentBlock.instance_eval do
  def default_terms_text
    ERB.new(
        IO.read(
          Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'terms.html.erb')
        )
      ).result
  end
end
