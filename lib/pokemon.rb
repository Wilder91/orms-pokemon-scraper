class Pokemon
    attr_reader :id, :name, :type, :hp, :db
  @@all = []

  def initialize (id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
    @@all << self
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?);
    SQL
    
    db.execute(sql, [name, type])
    
  end

  def self.find(id, db)
    statement = db.prepare("SELECT * FROM pokemon WHERE id = ?")
    result_set = statement.execute(id)

    results = result_set.collect do |row|
      pokemon = Pokemon.new(name: row[1], type: row[2], db: db, id: id)
      hp = row[3]
      pokemon
    end
    results[0]
  end
  def alter_hp(new_hp)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL
    db.execute(sql, [new_hp, id])
    end
end

