# frozen_string_literal: true

SecureHeaders::Configuration.default do |config|
  config.hsts = "max-age=#{5.years.to_i}"
  config.x_frame_options = "ALLOW-FROM https://*.eventfuel.io"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.csp = {
    # directive values: these values will directly translate into source directives
    default_src: %w['self' https:],
    child_src: %w['self' *.intercom.io *.intercomcdn.com
                  *.eventfuel.io www.eventfuel.io *.eventacc.es],
    connect_src: %w['self' balor.eventfuel.io localhost:3035 ws://localhost:3035 wss://*.intercom.io https://*.intercom.io https://*.intercomcdn.com],
    font_src: %w['self' cdn.materialdesignicons.com js.intercomcdn.com fonts.gstatic.com fonts.googleapis.com],
    img_src: %w['self' http: data: https: blob:],
    media_src: %w['self' https://*.intercomcdn.com],
    object_src: %w['self'],
    # inline needed for ruby output TODO: remove this javascript and use data- tags and lazy loaded data retrieval
    # unsafe eval used for underscore and the calendar library... #TODO try to find an alternate lib
    script_src: %w['self' 'unsafe-inline' 'unsafe-eval' ajax.cloudflare.com use.fontawesome.com widget.intercom.io js.intercomcdn.com ajax.googleapis.com *.eventfuel.io *.eventacc.es],
    style_src: %w['self' 'unsafe-inline' fonts.googleapis.com use.fontawesome.com cdn.materialdesignicons.com *.intercom.io *.intercomcdn.com],
    base_uri: %w['self'],
    form_action: %w['self' *.intercom.io *.intercomcdn.com],
    frame_ancestors: %w['self' *.eventacc.es *.eventfuel.io www.eventfuel.io],
    plugin_types: %w[application/pdf]
  }

  # pedro update: added referrer policy
  config.referrer_policy = "strict-origin-when-cross-origin"

  #if Rails.env.development?
    #config.csp[:script_src] = %w['self' 'unsafe-inline' 'unsafe-eval' use.fontawesome.com widget.intercom.io js.intercomcdn.com ajax.googleapis.com *.eventfuel.io *.eventacc.es]
  #else
  config.csp.merge(
    # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    preserve_schemes: true,
    # see [http://www.w3.org/TR/mixed-content/](http://www.w3.org/TR/mixed-content/)
    block_all_mixed_content: true,
    # see https://www.w3.org/TR/upgrade-insecure-requests/
    upgrade_insecure_requests: true
  )
    #config.csp[:script_src] = %w['self' 'unsave-eval' 'unsafe-inline' use.fontawesome.com widget.intercom.io js.intercomcdn.com ajax.googleapis.com *.eventfuel.io *.eventacc.es]
  #end
end
