from tkinter import *
from tkinter import ttk

class User_Win:
    def __init__(self, root):
        self.root = root
        self.root.title("Event Management System - User Details")
        self.root.geometry("1465x835+230+80")

        # Title Label
        lbl_title = Label(self.root, text="Add User Details", font=("times new roman", 38, "bold"), bg="green", fg="white", bd=4, relief=RIDGE)
        lbl_title.place(x=0, y=0, width=1708, height=50)

        # User Details Frame
        labelframe_left = LabelFrame(self.root, bd=2, relief=RIDGE, text="User Details", font=("times new roman", 12, "bold"), padx=2)
        labelframe_left.place(x=5, y=50, width=420, height=780)

        # User Reference
        lbl_user_ref = Label(labelframe_left, text="User Ref", font=("arial", 12, "bold"), padx=2, pady=6)
        lbl_user_ref.grid(row=0, column=0, sticky=W)
        self.entry_ref = ttk.Entry(labelframe_left, font=("arial", 13, "bold"))
        self.entry_ref.grid(row=0, column=1)

        # First Name
        lbl_uname = Label(labelframe_left, text="Name", font=("arial", 12, "bold"), padx=2, pady=6)
        lbl_uname.grid(row=1, column=0, sticky=W)
        self.txt_name = ttk.Entry(labelframe_left, font=("arial", 13, "bold"))
        self.txt_name.grid(row=1, column=1)

        # Last Name
        lbl_ulname = Label(labelframe_left, text="Last Name", font=("arial", 12, "bold"), padx=2, pady=6)
        lbl_ulname.grid(row=2, column=0, sticky=W)
        self.txt_lname = ttk.Entry(labelframe_left, font=("arial", 13, "bold"))
        self.txt_lname.grid(row=2, column=1)

        # Phone Number
        lbl_uphone = Label(labelframe_left, text="Phone Number", font=("arial", 12, "bold"), padx=2, pady=6)
        lbl_uphone.grid(row=3, column=0, sticky=W)
        self.txt_phone = ttk.Entry(labelframe_left, font=("arial", 13, "bold"))
        self.txt_phone.grid(row=3, column=1)

        # Email
        lbl_uemail = Label(labelframe_left, text="Email", font=("arial", 12, "bold"), padx=2, pady=6)
        lbl_uemail.grid(row=4, column=0, sticky=W)
        self.txt_email = ttk.Entry(labelframe_left, font=("arial", 13, "bold"))
        self.txt_email.grid(row=4, column=1)

        # Buttons Frame
        btn_frame = Frame(labelframe_left, bd=2, relief=RIDGE)
        btn_frame.place(x=0, y=350, width=410, height=40)

        # Save Button
        btn_save = Button(btn_frame, text="Save", command=self.save_user, font=("arial", 12, "bold"), bg="green", fg="white", width=10)
        btn_save.grid(row=0, column=0, padx=10)

        # Update Button
        btn_update = Button(btn_frame, text="Update", command=self.update_user, font=("arial", 12, "bold"), bg="blue", fg="white", width=10)
        btn_update.grid(row=0, column=1, padx=10)

        # Delete Button
        btn_delete = Button(btn_frame, text="Delete", command=self.delete_user, font=("arial", 12, "bold"), bg="red", fg="white", width=10)
        btn_delete.grid(row=0, column=2, padx=10)

        # Data Table Frame
        table_frame = Frame(self.root, bd=2, relief=RIDGE)
        table_frame.place(x=430, y=50, width=1030, height=780)

        # Scrollbars
        scroll_x = Scrollbar(table_frame, orient=HORIZONTAL)
        scroll_y = Scrollbar(table_frame, orient=VERTICAL)

        self.user_table = ttk.Treeview(table_frame, columns=("ref", "name", "lname", "phone", "email"),
                                    xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
        scroll_x.pack(side=BOTTOM, fill=X)
        scroll_y.pack(side=RIGHT, fill=Y)

        scroll_x.config(command=self.user_table.xview)
        scroll_y.config(command=self.user_table.yview)

        self.user_table.heading("ref", text="User Ref")
        self.user_table.heading("name", text="Name")
        self.user_table.heading("lname", text="Last Name")
        self.user_table.heading("phone", text="Phone")
        self.user_table.heading("email", text="Email")

        self.user_table["show"] = "headings"
        self.user_table.column("ref", width=100)
        self.user_table.column("name", width=200)
        self.user_table.column("lname", width=200)
        self.user_table.column("phone", width=150)
        self.user_table.column("email", width=250)

        self.user_table.pack(fill=BOTH, expand=1)

    def save_user(self):
        # Logic for saving user to the database
        pass

    def update_user(self):
        # Logic for updating user details in the database
        pass

    def delete_user(self):
        # Logic for deleting user from the database
        pass

if __name__ == "__main__":
    root = Tk()
    obj = User_Win(root)
    root.mainloop()
