#TMUX Tricks

#Create Session / Create with Name
tmux
tmux new 
tmux new-session
tmux new -s $SESSION-NAME

#Detach Session 
ctrl + b + d

#View Sessions and Rename
tmux ls
tmux list-sessions
ctrl + b + s ##Inside tmux terminal
tmux rename-session [-t session-name] [new-session-name]  ##Rename 

#Kill Session 
tmux kill-session -t [session-name]

#Attach Session 
tmux attach -t [session-name]

#Create and Kill Window
ctrl + b + c  ## Will Create new Window 
ctrl + b + &  ## Will Kill current Window

#Select Window
ctrl + b + $WindowID ## ID are Natural integers 0,1 etc 
ctrl + b + n ## Next Window 
ctrl + b + p ## Previous Window 

#Create/Close Panes
ctrl + b + % ## Vertical Split
ctrl + b + " ## Horizontal Split
ctrl + b + x ## Kill Pane

#Python Tmux Lib Example; Create Windows, Splits Panes, sends Keys and tmux options.
import libtmux
def tmux_ssh_spider(username,site,device_dict):
  '''
    tmux_ssh_spider requires Site to create tmux session and device_dict to create windows inside tmux.
  '''
  tmux_server = libtmux.Server()
  site = site.replace(".","_")
  site = site.split("_")[1]
  if tmux_server.find_where({ "session_name": site }):
    sys.exit("Duplicate tmux session found, script will now exit")
  else:
    subprocess.Popen(['tmux', 'new', '-d', '-s', site])
    tmux_session = tmux_server.find_where({ "session_name": site })
    for k,v in device_dict.items():
      tmux_window = tmux_session.new_window(attach=False, window_name=k)
      for vitem in v:
        vpane = tmux_window.split_window(attach=False,vertical=False)
        tmux_window.select_layout(layout="tiled")
        vpane.send_keys('ssh -o StrictHostKeyChecking=no ' + username + '@' + vitem, enter=False)
      sync_needed = str(raw_input("Do you want to enable synchronize-panes (Y|N) ? : "))
      sync_needed = sync_needed.upper()
      if sync_needed == "Y":
        tmux_window.set_window_option("synchronize-panes","on")
