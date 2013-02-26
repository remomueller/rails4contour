json.name DEFAULT_APP_NAME

json.version do
  json.string Rails4Contour::VERSION::STRING
  json.major Rails4Contour::VERSION::MAJOR
  json.minor Rails4Contour::VERSION::MINOR
  json.tiny Rails4Contour::VERSION::TINY
  json.build Rails4Contour::VERSION::BUILD
end
