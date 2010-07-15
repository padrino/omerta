MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'omerta_development'
  when :production  then MongoMapper.database = 'omerta_production'
  when :test        then MongoMapper.database = 'omerta_test'
end
