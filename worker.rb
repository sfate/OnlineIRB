require './app'

# check queue
job 'evaluate_send' do |args|
  answer = unless args.empty?
    return "StandardError: Can't process this line!" if unacceptable_command?(args[:code_block])
    begin
      " => #{eval(command)}"
    rescue => ex
      ex
    end
  end
  link = "http://onirb.herokuapp.com"
  RestClient.post "#{link}/update", :id => args[:id], :answer => answer
end

# check for system evaluation commands
def unacceptable_command?(command)
  # array of denied commands in regexp
  [
    /system[\s(]/,
    /exec[\s(]/,
    /%x\[/
  ].each do |regexp|
    return true unless command.scan(regexp).empty?
  end
  false
end

