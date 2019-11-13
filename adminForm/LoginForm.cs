using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MetroFramework.Forms;

namespace adminForm
{
    public partial class LoginForm : MetroForm
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void Login_btn_Click(object sender, EventArgs e)
        {
            if (ID_txt.Text == "admin" && PW_txt.Text == "1111")
            {
                this.Hide();

                adminForm adminform = new adminForm();
                adminform.Show();
            }

            else
            {
                MessageBox.Show("아이디와 비밀번호를 확인해 주세요.");
            }
        }
    }
}
