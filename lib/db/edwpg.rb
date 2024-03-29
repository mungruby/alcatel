

require 'win32ole'
 
 
#
# This class manages the database connection and queries
#
class SqlServer

  #
  # Use this method to automatically open and close the connection
  # 
  def self.create source, database
    db = SqlServer.new source, database
    db.open
    yield db
    db.close
  end

   
  attr_accessor :connection, :fields, :data

  def initialize source, database
    @source = source
    @database = database
    @connection = nil
    @fields = nil
    @data = nil
  end


  #
  # Opens an ADO connection to the SQL Server database
  #
  def open
    @connection = WIN32OLE.new 'ADODB.Connection'
    @connection.Open <<-CONNECTION_STRING
      Provider=SQLOLEDB.1;
      Persist Security Info=False;
      Data Source=#{@source};
      Initial Catalog=#{@database};
      Trusted_Connection=Yes;
    CONNECTION_STRING
  end


  #
  # Performs an SQL query and populates the fields and data instance variables
  #
  def query sql 

    # Create an instance of an ADO Recordset
    recordset = WIN32OLE.new 'ADODB.Recordset' 

    # Open the recordset, using an SQL statement and the
    # existing ADO connection
    recordset.Open sql, @connection 

    # Create and populate an array of field names
    @fields = []
    recordset.Fields.each {|f| @fields << f.Name }

    begin
      # Move to the first record/row, if any exist
      recordset.MoveFirst
      # Grab all records
      @data = recordset.GetRows
    rescue
        @data = []
    end

    # Close the recordset
    recordset.Close

    # An ADO Recordset's GetRows method returns an array
    # of columns, so we'll use the transpose method to
    # convert it to an array of rows
    @data = @data.transpose
  end


  #
  # Closes the database connection
  #
  def close
    @connection.Close
  end
end  # class SqlServer



#
# This class is for connecting specifically to EDW Playground
#
# The default database is DM_Alcatel
#
class EDWPlayground

  SOURCE = 'DWDSQL01\\SQL01'
  DATABASE = 'DM_Alcatel'

  attr_reader :source, :database

  def initialize parms = {}
    @source = parms[:source] || SOURCE
    @database = parms[:database] || DATABASE
  end

  #
  # call this method to obtain a connection to the database
  #
  def connect
    SqlServer.create(source, database) { |conn| yield conn }
  end
end


