require("pg")
class Property

  attr_accessor :value, :no_bedrooms, :year_built, :build
  attr_reader :id

  def initialize(options)
    @value = options["value"].to_i
    @no_bedrooms = options["no_bedrooms"].to_i
    @year_built = options["year_built"]
    @build = options["build"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "INSERT INTO homes (value, no_bedrooms, year_built, build) VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@value, @no_bedrooms, @year_built, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "UPDATE homes SET (value, no_bedrooms, year_built, build) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@value, @no_bedrooms, @year_built, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "DELETE FROM homes WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "DELETE FROM homes"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Property.select_all()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "SELECT * FROM homes"
    db.prepare("select_all", sql)
    homes = db.exec_prepared("select_all")
    results = homes.map { |home| Property.new(home) }
    db.close()
    return results
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "SELECT * FROM homes WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    result = db.exec_prepared("find", values)[0]
    db.close()
    return Property.new(result)
  end

  def Property.find_by_value()
    db = PG.connect({dbname: "homes", host: "localhost"})
    sql = "SELECT * FROM homes WHERE value BETWEEN 110000 AND 230000"
    db.prepare("find", sql)
    homes = db.exec_prepared("find")
    results = homes.map { |home| Property.new(home) }
    db.close()
    return results
  end

end
