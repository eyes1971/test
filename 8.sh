#!/usr/bin/python

import AppKit
import urllib2
import base64
import platform
import subprocess
import sys

if sys.version_info < (3, 0):
    # Python 2
    import Tkinter as tk
else:
    # Python 3
    import tkinter as tk

auH = sys.argv[4]
apH = sys.argv[5]

def DecryptString(inputString, salt, passphrase):
    '''Usage: >>> DecryptString("Encrypted String", "Salt", "Passphrase")'''
    p = subprocess.Popen(['/usr/bin/openssl', 'enc', '-aes256', '-d', '-a', '-A', '-S', salt, '-k', passphrase], stdin = subprocess.PIPE, stdout = subprocess.PIPE)
    return p.communicate(inputString)[0]

api_user = DecryptString(auH, "a0b740a443234587fa1275", "0453455efd854df5e73517bfc2e79").strip()
api_password = DecryptString(apH, "583b483f4084543e2191", "18e8f98f4be245454b0bbe4737a18").strip()
jss_url = "https://yourjamfproserver:8443"


def update_static_group(ser_number, grp_id, update_type):

    xml = "<computer_group><" + update_type + "><computer><serial_number>" + ser_number + "</serial_number></computer></" + update_type + "></computer_group>"

    request = urllib2.Request(jss_url + "/JSSResource/computergroups/id/" + grp_id)
    request.add_header('Authorization', 'Basic ' + base64.b64encode(api_user + ':' + api_password))
    request.add_header('Content-Type', 'text/xml')
    request.get_method = lambda: 'PUT'
    response = urllib2.urlopen(request, xml)
    print(response)

class App(tk.Frame):
    def __init__(self, master):
        tk.Frame.__init__(self, master)
        self.pack()
        self.master.title("Scope Manager")
        self.master.resizable(False, False)
        self.master.tk_setPalette(background='#ececec')

        self.master.protocol('WM_DELETE_WINDOW', self.click_cancel)
        self.master.bind('<Return>', self.click_reset)
        self.master.bind('<Escape>', self.click_cancel)

        x = (self.master.winfo_screenwidth() - self.master.winfo_reqwidth()) / 2
        y = (self.master.winfo_screenheight() - self.master.winfo_reqheight()) / 3
        self.master.geometry("+{}+{}".format(x, y))

        self.master.config(menu=tk.Menu(self.master))

        self.grp_list = []

        self.status_msg = tk.StringVar()

        self.var1 = tk.IntVar()
        self.var2 = tk.IntVar()
        self.var3 = tk.IntVar()
        self.var4 = tk.IntVar()
        self.var5 = tk.IntVar()
        self.var6 = tk.IntVar()
        self.var7 = tk.IntVar()
        self.var8 = tk.IntVar()
        self.var9 = tk.IntVar()
        self.var10 = tk.IntVar()
        self.var11 = tk.IntVar()
        self.var12 = tk.IntVar()
        self.var13 = tk.IntVar()
        self.var14 = tk.IntVar()
        self.var15 = tk.IntVar()
        self.var16 = tk.IntVar()
        self.var17 = tk.IntVar()

        self.var1.set(0)
        self.var2.set(0)
        self.var3.set(0)
        self.var4.set(0)
        self.var5.set(0)
        self.var6.set(0)
        self.var7.set(0)
        self.var8.set(0)
        self.var9.set(0)
        self.var10.set(0)
        self.var11.set(0)
        self.var12.set(0)
        self.var13.set(0)
        self.var14.set(0)
        self.var15.set(0)
        self.var16.set(0)
        self.var17.set(0)

        dialog_frame = tk.Frame(self)
        dialog_frame.pack(padx=20, pady=15)

        tk.Label(dialog_frame, text="1. Input a serial number or serial number list using ','.\n2. Select an application or applications to scope.\n3. Click button").pack()

        input_frame = tk.Frame(self)
        input_frame.pack(padx=20, pady=15)

        tk.Label(input_frame, text='Serial #(s):').grid(row=0, column=0, sticky='w')

        self.serial_input = tk.Entry(input_frame, background='white', width=24)
        self.serial_input.grid(row=0, column=1, sticky='w')
        self.serial_input.focus_set()

        chk_btn_frame = tk.Frame(self)
        chk_btn_frame.pack(anchor='w', padx=20, pady=15)

        chk1 = tk.Checkbutton(chk_btn_frame, text='iMovie', variable=self.var1)
        chk2 = tk.Checkbutton(chk_btn_frame, text='iMovie SS', variable=self.var2)
        chk3 = tk.Checkbutton(chk_btn_frame, text='Garageband', variable=self.var3)
        chk4 = tk.Checkbutton(chk_btn_frame, text='Garageband SS', variable=self.var4)
        chk5 = tk.Checkbutton(chk_btn_frame, text='iWork', variable=self.var5)
        chk6 = tk.Checkbutton(chk_btn_frame, text='iWork SS', variable=self.var6)
        chk7 = tk.Checkbutton(chk_btn_frame, text='Apple Configurator', variable=self.var7)
        chk8 = tk.Checkbutton(chk_btn_frame, text='Apple Configurator SS', variable=self.var8)

        chk9 = tk.Checkbutton(chk_btn_frame, text='Photoshop SS', variable=self.var9)
        chk10 = tk.Checkbutton(chk_btn_frame, text='Acrobat Pro', variable=self.var10)
        chk11 = tk.Checkbutton(chk_btn_frame, text='Acrobat Pro SS', variable=self.var11)
        chk12 = tk.Checkbutton(chk_btn_frame, text='Animate SS', variable=self.var12)
        chk13 = tk.Checkbutton(chk_btn_frame, text='Audition SS', variable=self.var13)
        chk14 = tk.Checkbutton(chk_btn_frame, text='Illustrator SS', variable=self.var14)
        chk15 = tk.Checkbutton(chk_btn_frame, text='InDesign SS', variable=self.var15)
        chk16 = tk.Checkbutton(chk_btn_frame, text='Lightroom SS', variable=self.var16)
        chk17 = tk.Checkbutton(chk_btn_frame, text='Premier Pro SS', variable=self.var17)

        chk1.grid(row=0, column=0, sticky='w')
        chk2.grid(row=1, column=0, sticky='w')
        chk3.grid(row=2, column=0, sticky='w')
        chk4.grid(row=3, column=0, sticky='w')
        chk5.grid(row=4, column=0, sticky='w')
        chk6.grid(row=5, column=0, sticky='w')
        chk7.grid(row=6, column=0, sticky='w')
        chk8.grid(row=7, column=0, sticky='w')
        chk9.grid(row=0, column=1, sticky='w')
        chk10.grid(row=1, column=1, sticky='w')
        chk11.grid(row=2, column=1, sticky='w')
        chk12.grid(row=3, column=1, sticky='w')
        chk13.grid(row=4, column=1, sticky='w')
        chk14.grid(row=5, column=1, sticky='w')
        chk15.grid(row=6, column=1, sticky='w')
        chk16.grid(row=7, column=1, sticky='w')
        chk17.grid(row=8, column=1, sticky='w')

        chk1.configure(command=lambda chkd=chk1: self.set_list(chkd))
        chk2.configure(command=lambda chkd=chk2: self.set_list(chkd))
        chk3.configure(command=lambda chkd=chk3: self.set_list(chkd))
        chk4.configure(command=lambda chkd=chk4: self.set_list(chkd))
        chk5.configure(command=lambda chkd=chk5: self.set_list(chkd))
        chk6.configure(command=lambda chkd=chk6: self.set_list(chkd))
        chk7.configure(command=lambda chkd=chk7: self.set_list(chkd))
        chk8.configure(command=lambda chkd=chk8: self.set_list(chkd))
        chk9.configure(command=lambda chkd=chk9: self.set_list(chkd))
        chk10.configure(command=lambda chkd=chk10: self.set_list(chkd))
        chk11.configure(command=lambda chkd=chk11: self.set_list(chkd))
        chk12.configure(command=lambda chkd=chk12: self.set_list(chkd))
        chk13.configure(command=lambda chkd=chk13: self.set_list(chkd))
        chk14.configure(command=lambda chkd=chk14: self.set_list(chkd))
        chk15.configure(command=lambda chkd=chk15: self.set_list(chkd))
        chk16.configure(command=lambda chkd=chk16: self.set_list(chkd))
        chk17.configure(command=lambda chkd=chk17: self.set_list(chkd))

        button_frame = tk.Frame(self)
        button_frame.pack(padx=5, pady=(0, 5), anchor='e')

        #self.clicked=[]
        button1 = tk.Button(button_frame, text="Add", width=8)
        button2 = tk.Button(button_frame, text="Remove", width=8)
        button3 = tk.Button(button_frame, text="Reset", width=8)
        button4 = tk.Button(button_frame, text="Cancel", width=8)

        button1.pack(side='right')
        button2.pack(side='right')
        button3.pack(side='right')
        button4.pack(side='right')

        button1.configure(command=lambda btn=button1: self.add_to_grp(btn))
        button2.configure(command=lambda btn=button2: self.remove_from_grp(btn))
        button3.configure(command=lambda btn=button3: self.click_reset())
        button4.configure(default='active', command=lambda btn=button4: self.click_cancel())

    def click_reset(self, event=None):
        self.var1.set(0)
        self.var2.set(0)
        self.var3.set(0)
        self.var4.set(0)
        self.var5.set(0)
        self.var6.set(0)
        self.var7.set(0)
        self.var8.set(0)
        self.var9.set(0)
        self.var10.set(0)
        self.var11.set(0)
        self.var12.set(0)
        self.var13.set(0)
        self.var14.set(0)
        self.var15.set(0)
        self.var16.set(0)
        self.var17.set(0)

        self.grp_list = []
        self.serial_input.delete(0, 'end')

    def set_list(self, chkd):
        chk_text = chkd.cget("text")
        #print("The user selected " + chk_text)
        if chk_text == "iMovie":
            grp_id = "3270"
            ck_value = self.var1.get()
        elif chk_text == "iMovie SS":
            grp_id = "3418"
            ck_value = self.var2.get()
        elif chk_text == "Garageband":
            grp_id = "3282"
            ck_value = self.var3.get()
        elif chk_text == "Garageband SS":
            #grp_id = "3440" #for testig
            grp_id = "3416"
            ck_value = self.var4.get()
        elif chk_text == "iWork":
            grp_id = "3407"
            ck_value = self.var5.get()
        elif chk_text == "iWork SS":
            #grp_id = "3441" #for testing
            grp_id = "3417"
            ck_value = self.var6.get()
        elif chk_text == "Apple Configurator":
            grp_id = "3285"
            ck_value = self.var7.get()
        elif chk_text == "Apple Configurator SS":
            grp_id = "3442"
            ck_value = self.var8.get()
        elif chk_text == "Photoshop SS":
            grp_id = "3203"
            ck_value = self.var9.get()
        elif chk_text == "Acrobat Pro":
            grp_id = "3196"
            ck_value = self.var10.get()
        elif chk_text == "After Effects":
            grp_id = "3197"
            ck_value = self.var11.get()
        elif chk_text == "Animate SS":
            grp_id = "3198"
            ck_value = self.var12.get()
        elif chk_text == "Audition SS":
            grp_id = "3199"
            ck_value = self.var13.get()
        elif chk_text == "Illustrator SS":
            grp_id = "3200"
            ck_value = self.var14.get()
        elif chk_text == "InDesign SS":
            grp_id = "3201"
            ck_value = self.var15.get()
        elif chk_text == "Lightroom SS":
            grp_id = "3202"
            ck_value = self.var16.get()
        elif chk_text == "Premier Pro SS":
            #grp_id = "3355" #for testing
            grp_id = "3204"
            ck_value = self.var17.get()


        if ck_value == 1:
            self.grp_list.append(grp_id)
        elif ck_value == 0:
            self.grp_list.remove(grp_id)

        #print(self.grp_list)


    def click_cancel(self, event=None):
        print("The user clicked 'Cancel'")
        self.master.destroy()

    def add_to_grp(self, btn):
        upd_typ = "computer_additions"
        text = btn.cget("text")
        print("The user clicked " + text)
        ser_list = self.serial_input.get()
        print(ser_list)
        serials = ser_list.split(",")
        for ea_ser in serials:
            for ea_grp in self.grp_list:

                print("Serial: " + ea_ser + " Group: " + ea_grp )
                update_static_group(ea_ser, ea_grp, upd_typ)


    def remove_from_grp(self, btn):
        upd_typ = "computer_deletions"
        text = btn.cget("text")
        print("The user clicked " + text)
        ser_list = self.serial_input.get()
        print(ser_list)
        serials = ser_list.split(",")
        for ea_ser in serials:
            for ea_grp in self.grp_list:
                print("Serial: " + ea_ser + " Group: " + ea_grp )
                update_static_group(ea_ser, ea_grp, upd_typ)





if __name__ == '__main__':
    info = AppKit.NSBundle.mainBundle().infoDictionary()
    info['LSUIElement'] = True

    root = tk.Tk()
    app = App(root)
    AppKit.NSApplication.sharedApplication().activateIgnoringOtherApps_(True)
    app.mainloop()

"""
There are a few items left to address before we have a working GUI that matches the standard macOS dialogs. When running
a Python app using Tkinter the Python launcher's icon will appear in the Dock. This can be dynamically flagged to run
without the Dock icon by loading and manupulating the launcher's 'Info.plist' before the main window has been created.
'AppKit' will be used in our main function to do this.

Lastly, to allow the user to control the window as they would any other macOS dialog, we will bind the '<Return>' and
'<Escape>' keys to our 'OK' and 'Cancel' methods. We will also override the function of the close button on the GUI
window to point to our 'Cancel' method to keep control of the teardown.

Because we are now using alternative triggers for these funtions we must add an 'event' parameter to accept the callback
that is passed by the binding. The default value is set to 'None' for when the buttons are used.
"""