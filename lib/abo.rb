module ABO
  
  class WrongFormatError < StandardError; end

  class Writer  
    #záznam UHL1
    attr_accessor :record
    
    #Hlavička účetního souboru
    attr_accessor :file_header
    
    #Hlavička skupiny
    attr_accessor :group_header
    
    #Položka jednotlivého příkazu
    attr_accessor :payment_order
    
    class Record
      
      #datum
      attr_accessor :date
      
      #název klienta
      attr_accessor :client_name
      
      #číslo klienta
      attr_accessor :client_number
      
      #interval účetních souborů, začátek
      attr_accessor :interval_start
      
      #interval účetních souborů, konec
      attr_accessor :interval_stop
      
      #kód pevná část
      attr_accessor :public_code
      
      #kód tajná část
      attr_accessor :secret_code
      
      def date=(value)
        raise ABO::WrongFormatError, "Record#date=" unless value.instance_of?(Date)
        @date = value
      end
      
      def date
        raise ABO::WrongFormatError, "Record#date" unless @date.instance_of?(Date)
        @date.strftime("%d%m%y")
      end
      
      def client_name
        raise ABO::WrongFormatError, "Record#client_name" unless @client_name.instance_of?(String)
        @client_name.rjust(20)
      end
      
      def client_number
        raise ABO::WrongFormatError, "Record#client_number" unless @client_number.instance_of?(String)
        @client_number.rjust(10)
      end
      
      def interval_start
        raise ABO::WrongFormatError, "Record#interval_start" unless @interval_start.instance_of?(Fixnum)
        "%03d" % @interval_start
      end
      
      def interval_stop
        raise ABO::WrongFormatError, "Record#interval_stop" unless @interval_stop.instance_of?(Fixnum)
        "%03d" % @interval_stop
      end
      
      def to_abo
        "UHL1#{date}#{client_name}#{client_number}#{interval_start}#{interval_stop}#{public_code}#{secret_code}\n"
      end
    end
    
    class FileHeader
      
      PAYMENT = "1501"
      INKASO = "1502"
      
      #druh dat
      attr_accessor :date_type
      
      #číslo účetního souboru
      attr_accessor :file_number
      
      #směrový kód banky
      attr_accessor :bank_code
        
      def end_block
        "5 +\n"
      end
      
      def to_abo
        "1 #{date_type} #{file_number} #{bank_code}\n"
      end
      
    end
    
    class GroupHeader
      
      #číslo účtu příkazce
      attr_accessor :payers_account_number
      
      #celková částka skupiny
      attr_accessor :group_amount
      
      #datum splatnosti
      attr_accessor :due_date
      
      def due_date=(value)
        raise ABO::WrongFormatError unless value.instance_of?(Date)
        @due_date = value 
      end
      
      def due_date
        raise ABO::WrongFormatError unless @due_date.instance_of?(Date)
        @due_date.strftime("%d%m%y")
      end
      
      def end_block
        "3 +\n"
      end
      
      def to_abo
        "2 #{payers_account_number} #{group_amount} #{due_date}\n"
      end
        
    end
    
    class PaymentOrder
      
      #číslo účtu kredit
      attr_accessor :credit_account_number
      
      #částka
      attr_accessor :amount
      
      #variabilní symbol
      attr_accessor :variable_symbol
      
      #konstantní symbol
      attr_accessor :constant_symbol
      
      def amount
        "%012d" % @amount
      end
      
      def variable_symbol
        "%010d" % @variable_symbol.to_i
      end
      
      def constant_symbol
        "%010d" % @constant_symbol.to_i
      end
      
      def to_abo
        "#{credit_account_number} #{amount} #{variable_symbol} #{constant_symbol}\n"
      end
    
    end
    
    def initialize
      @record = Record.new
      @record.interval_start = 1
      @record.interval_stop = 1
      @file_header = FileHeader.new
      @group_header = GroupHeader.new
      @payment_orders = []
    end
    
    def to_abo
      prepare
      string = ""
      string << @record.to_abo
      string << @file_header.to_abo
      string << @group_header.to_abo
      @payment_orders.each do |p|
        string << p.to_abo
      end
      string << @group_header.end_block
      string << @file_header.end_block
      
      string
    end
    
    private
    
    def prepare
      @group_header.group_amount = sum_amounts
    end
    
    def sum_amounts
      @payment_orders.inject(0){|p,c| p + c.amount.to_i}
    end
    
  end

end
