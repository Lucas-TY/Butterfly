
# a function that asking for input(with a timer)
# @param seconds [Number] Countup if it's 0, otherwise will count down
# @param seconds [String] the print message
# @return [Array(Input,Number)] the first index contain the input value, and the second is time use.
# @author Lucas Wu 

def timer_input(seconds,message)
    @limit=seconds
    @used=0
    input=nil
    Thread.new do 
        input=gets     
                                                                        
    end
    
    timer=Thread.new do
        
        loop do 
            if @limit!=0 
                print "your time left: #{(@limit-@used).round}, "+message
                sleep 0.1
                @used+=0.1 
                print "\r"
                break if @used >= @limit || input!=nil 
            
            else
            print "your time spent: #{(@used).round}, "+message
            sleep 0.1
            @used+=0.1 
            print "\r"
            break if input!=nil 
            end
        end
    end
    timer.join
    array=[input,@used.round]       
    end

