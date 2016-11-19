Kaminari.configure do |config|
  config.default_per_page = Integer(ENV.fetch('PAGINATION_DEFAULT_PER_PAGE'))
  # config.max_per_page = nil
  config.window = Integer(ENV.fetch('PAGINATION_DEFAULT_WINDOW'))
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end
