namespace adminForm
{
    partial class Form1
    {
        /// <summary>
        /// 필수 디자이너 변수입니다.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 사용 중인 모든 리소스를 정리합니다.
        /// </summary>
        /// <param name="disposing">관리되는 리소스를 삭제해야 하면 true이고, 그렇지 않으면 false입니다.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 디자이너에서 생성한 코드

        /// <summary>
        /// 디자이너 지원에 필요한 메서드입니다. 
        /// 이 메서드의 내용을 코드 편집기로 수정하지 마세요.
        /// </summary>
        private void InitializeComponent()
        {
            this.ID_lb = new System.Windows.Forms.Label();
            this.ID_txt = new System.Windows.Forms.TextBox();
            this.PW_lb = new System.Windows.Forms.Label();
            this.PW_txt = new System.Windows.Forms.TextBox();
            this.Login_btn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // ID_lb
            // 
            this.ID_lb.AutoSize = true;
            this.ID_lb.Location = new System.Drawing.Point(152, 161);
            this.ID_lb.Name = "ID_lb";
            this.ID_lb.Size = new System.Drawing.Size(16, 12);
            this.ID_lb.TabIndex = 1;
            this.ID_lb.Text = "ID";
            // 
            // ID_txt
            // 
            this.ID_txt.Location = new System.Drawing.Point(208, 152);
            this.ID_txt.Name = "ID_txt";
            this.ID_txt.Size = new System.Drawing.Size(163, 21);
            this.ID_txt.TabIndex = 3;
            // 
            // PW_lb
            // 
            this.PW_lb.AutoSize = true;
            this.PW_lb.Location = new System.Drawing.Point(152, 208);
            this.PW_lb.Name = "PW_lb";
            this.PW_lb.Size = new System.Drawing.Size(23, 12);
            this.PW_lb.TabIndex = 4;
            this.PW_lb.Text = "PW";
            // 
            // PW_txt
            // 
            this.PW_txt.Location = new System.Drawing.Point(208, 199);
            this.PW_txt.Name = "PW_txt";
            this.PW_txt.Size = new System.Drawing.Size(163, 21);
            this.PW_txt.TabIndex = 5;
            // 
            // Login_btn
            // 
            this.Login_btn.Font = new System.Drawing.Font("굴림", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(129)));
            this.Login_btn.Location = new System.Drawing.Point(449, 152);
            this.Login_btn.Name = "Login_btn";
            this.Login_btn.Size = new System.Drawing.Size(126, 68);
            this.Login_btn.TabIndex = 6;
            this.Login_btn.Text = "Login";
            this.Login_btn.UseVisualStyleBackColor = true;
            this.Login_btn.Click += new System.EventHandler(this.Login_btn_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.Login_btn);
            this.Controls.Add(this.PW_txt);
            this.Controls.Add(this.PW_lb);
            this.Controls.Add(this.ID_txt);
            this.Controls.Add(this.ID_lb);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label ID_lb;
        private System.Windows.Forms.TextBox ID_txt;
        private System.Windows.Forms.Label PW_lb;
        private System.Windows.Forms.TextBox PW_txt;
        private System.Windows.Forms.Button Login_btn;
    }
}

