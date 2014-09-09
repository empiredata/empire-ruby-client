
class Empire
  
  # Run automatic test of all services from YAML
  def walkthrough
    @last_service = nil
    @last_table = nil

    unless @service_secrets
      puts "Please connect some services in https://login.empiredata.co, and download the new yaml file"
      return 
    end

    @service_secrets.each do |secret|
      service = secret[0]
      walkthrough_service(service)
    end

    walkthrough_materialized_view(@last_service, @last_table)

    nil
  end

  private

  def walkthrough_service(service)
    puts "empire.connect '#{service}'"
    begin
      connect service
    rescue
      puts "Problem connecting to #{service}"
      return
    end

    tables = describe service

    unless tables and tables['service'] and tables['service']['tables']
      puts "Can't find tables belonging to #{service}"
      return
    end

    tables['service']['tables'].each do |table_data|
      table = table_data['table']
      walkthrough_table(service, table)
    end

    @last_service = service
  end

  def walkthrough_table(service, table)
    if service == "mailchimp"
      # These mailchimp tables can only be queried when filtering by a particular list.
      if ["list_member", "campaign", "campaign_sent_to", "campaign_opened"].include? table
        return
      end
    end

    begin
      sql = "SELECT * FROM #{service}.#{table} LIMIT 5"
      puts "empire.query '#{sql}'"
      query(sql) do |row|
        print_row(row)
      end
    rescue Exception => e
      puts "Problem with #{service}.#{table}"
    end

    @last_table = table
  end

  def walkthrough_materialized_view(service, table)
    unless @end_user
      puts "Please specify an end_user parameter when instantiating the client, so that you can try materialized views"
      return
    end

    puts "empire.materialize_view('view_name', 'SELECT * FROM #{service}.#{table} LIMIT 5')"
    materialize_view('view_name', "SELECT * FROM #{service}.#{table} LIMIT 5")

    puts "until empire.view_ready? 'view_name'\n  sleep 0.01\nend"
    until view_ready? 'view_name'
      sleep 0.01
    end

    puts "empire.query 'SELECT * FROM view_name'"
    query('SELECT * FROM view_name') do |row|
      print_row(row)
    end

    puts "empire.drop_view 'view_name'"
    drop_view 'view_name'
  end

  def print_row(row, max_length = 70)
      fragment = row.slice(0, max_length)
      if fragment.length == max_length
        fragment = fragment + "..."
      end
      puts "   #{fragment}"
    end
end
