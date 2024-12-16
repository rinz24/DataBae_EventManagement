from tkinter import *
from tkinter import ttk, messagebox
import mysql.connector

class Invitation_Win:
    def __init__(self, root):
        self.root = root
        self.root.title("Invitation Management")
        self.root.geometry("900x600+200+100")

        # Title
        lbl_title = Label(
            self.root, text="Manage Invitations", font=("times new roman", 20, "bold"),
            bg="green", fg="white", bd=4, relief=RIDGE
        )
        lbl_title.place(x=0, y=0, width=900, height=50)

        # Main Frame
        main_frame = Frame(self.root, bd=4, relief=RIDGE)
        main_frame.place(x=10, y=60, width=880, height=520)

        # Labels and Entries
        lbl_user_id = Label(main_frame, text="User ID:", font=("times new roman", 14))
        lbl_user_id.grid(row=0, column=0, padx=10, pady=5, sticky=W)
        self.txt_user_id = Entry(main_frame, font=("times new roman", 14), width=20)
        self.txt_user_id.grid(row=0, column=1, padx=10, pady=5, sticky=W)

        lbl_event_id = Label(main_frame, text="Event ID:", font=("times new roman", 14))
        lbl_event_id.grid(row=1, column=0, padx=10, pady=5, sticky=W)
        self.txt_event_id = Entry(main_frame, font=("times new roman", 14), width=20)
        self.txt_event_id.grid(row=1, column=1, padx=10, pady=5, sticky=W)

        lbl_invitation_id = Label(main_frame, text="Invitation ID:", font=("times new roman", 14))
        lbl_invitation_id.grid(row=2, column=0, padx=10, pady=5, sticky=W)
        self.txt_invitation_id = Entry(main_frame, font=("times new roman", 14), width=20)
        self.txt_invitation_id.grid(row=2, column=1, padx=10, pady=5, sticky=W)

        btn_fetch_invitation = Button(
            main_frame, text="Fetch Invitation", command=self.fetch_invitation,
            font=("times new roman", 12, "bold"), bg="blue", fg="white", cursor="hand1"
        )
        btn_fetch_invitation.grid(row=2, column=2, padx=10, pady=5)

        # Display Data Frame
        data_frame = Frame(main_frame, bd=4, relief=RIDGE)
        data_frame.place(x=10, y=120, width=850, height=370)

        scroll_x = Scrollbar(data_frame, orient=HORIZONTAL)
        scroll_y = Scrollbar(data_frame, orient=VERTICAL)
        self.data_table = ttk.Treeview(
            data_frame, columns=("ID", "Details"), xscrollcommand=scroll_x.set,
            yscrollcommand=scroll_y.set
        )

        scroll_x.pack(side=BOTTOM, fill=X)
        scroll_y.pack(side=RIGHT, fill=Y)
        scroll_x.config(command=self.data_table.xview)
        scroll_y.config(command=self.data_table.yview)

        self.data_table.heading("ID", text="ID")
        self.data_table.heading("Details", text="Details")
        self.data_table["show"] = "headings"
        self.data_table.column("ID", width=100)
        self.data_table.column("Details", width=600)
        self.data_table.pack(fill=BOTH, expand=1)

    def fetch_invitation(self):
        """Fetch invitation details based on the entered invitation ID."""
        invitation_id = self.txt_invitation_id.get()
        if not invitation_id:
            messagebox.showerror("Error", "Invitation ID is required", parent=self.root)
            return

        try:
            conn = mysql.connector.connect(
                host="localhost", user="root", password="", database="EventManagement"
            )
            cursor = conn.cursor()
            query = "SELECT * FROM Invitation WHERE InvitationID = %s"
            cursor.execute(query, (invitation_id,))
            rows = cursor.fetchall()

            if rows:
                self.data_table.delete(*self.data_table.get_children())
                for row in rows:
                    self.data_table.insert("", END, values=(row[0], row[1:]))
            else:
                messagebox.showinfo("Info", "No invitation found", parent=self.root)
            conn.close()
        except Exception as ex:
            messagebox.showerror("Error", f"Error due to: {str(ex)}", parent=self.root)

if __name__ == "__main__":
    root = Tk()
    obj = Invitation_Win(root)
    root.mainloop()
