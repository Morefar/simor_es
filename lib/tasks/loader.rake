namespace :parametric_data do
  desc "This task loads the parametric tables data from CSV files"
  task load: [:load_makes, :load_models, :load_colors, :load_kinds, :load_bodies]

  desc "Loads make data from a CSV file"
  task load_makes: :environment do
    CSV.foreach("lib/assets/makes.csv", headers: true, encoding: "UTF-8") do |row|
      make = Make.find_by_runt_code(row["runt_code"]) || Make.new
      make.attributes = row.to_hash.slice("runt_code", "name")
      make.save!
    end
  end

  desc "Loads models data from a CSV file"
  task load_models: [:load_makes, :environment] do
    CSV.foreach("lib/assets/models.csv", headers: true, encoding: "UTF-8") do |row|
      make = Make.find_by_runt_code(row["make_runt_code"])
      unless make.nil?
        model = Model.find_by_name(row["name"]) || Model.new
        model.name = row["name"].strip
        model.save!
        make.models << model
      end
    end
  end

  desc "Loads colors data from a CSV file"
  task load_colors: :environment do
    CSV.foreach("lib/assets/colors.csv", headers: true, encoding: "UTF-8") do |row|
      unless Color.find_by_name(row["name"].strip)
        color = Color.new
        color.name = row["name"].strip
        color.save!
      end
    end
  end

  desc "Loads vehicle-kind data from a CSV file"
  task load_kinds: :environment do
    CSV.foreach("lib/assets/kinds.csv", headers: true, encoding: "UTF-8") do |row|
      unless Kind.find_by_name(row["name"].strip)
        kind = Kind.new
        kind.name = row["name"].strip
        kind.save!
      end
    end
  end

  desc "Loads vehicle-body data from a CSV file"
  task load_bodies: :environment do
    CSV.foreach("lib/assets/bodies.csv", headers: true, encoding: "UTF-8") do |row|
      unless Body.find_by_name(row["name"].strip)
        body = Body.new
        body.name = row["name"].strip
        body.save!
      end
    end
  end

  desc "Creates contract categories"
  task load_categories: :environment do
    %w(Financiero Importación Inmobiliario Infraestructura Operacional Multileasing Municipal Leaseback).each do |cat|
      unless Category.find_by_name(cat)
        Category.create(name: cat)
      end
    end
  end

  desc "Create rights for all models"
  task load_rights: :environment do
    %w( contract
        asset
        inspection
        inspection_order
        document
        comment
        entity
        right
        grant
        assignment
        role
        user
        category
        make
        model
        build
        kind
        body
        insurance_company
        color
        identification_type
        cosigner).each do |model|
      %w(CREATE READ UPDATE DELETE).each do |action|
        Right.create(resource: model, operation: action)
      end
    end
  end

  desc "Create admin role"
  task load_admin_role: :environment do
    role = Role.create(name: "Administrador")
    role.rights << Right.all
  end

  desc "Create identification types"
  task load_identification_types: :environment do
    %w(CC NIT CE PASAPORTE OTRO).each do |type_name|
      IdentificationType.create(name: type_name)
    end
  end
end
