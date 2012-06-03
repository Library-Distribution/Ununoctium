class AuthorDialog extends CGUI
{
	; labels;
	labelName	:= this.AddControl("Text", "labelName",	"w100 x5 y5",	"Name:")
	labelUser	:= this.AddControl("Text", "labelUser",	"w100 x5 y35",	"(optional) User:")
	labelMail	:= this.AddControl("Text", "labelMail",	"w100 x5 y65",	"(optional) Mail:")
	labelURL	:= this.AddControl("Text", "labelURL",	"w100 x5 y95",	"(optional) Homepage URL:")

	; input:
	inputName	:= this.AddControl("Edit", "inputName",	"w200 x110 y5")
	inputUser	:= this.AddControl("Edit", "inputUser",	"w200 x110 y35")
	inputMail	:= this.AddControl("Edit", "inputMail",	"w200 x110 y65")
	inputURL	:= this.AddControl("Edit", "inputURL",	"w200 x110 y95")

	; buttons:
	btnSubmit	:= this.AddControl("Button", "btnSubmit", "w150 y125 x160",	"OK")
	btnCancel	:= this.AddControl("Button", "btnCancel", "w150 y125 x5",	"Cancel")

	Title := "Enter author data..."
	DestroyOnClose := true

	__New(submitCallback)
	{
		this.submitCallback := submitCallback
	}

	btnCancel_Click()
	{
		this.Destroy()
	}

	btnSubmit_Click()
	{
		if (this.inputName.Text != "")
		{
			this.submitCallback.(this.inputName.Text, this.inputUser.Text, this.inputMail.Text, this.inputURL.Text)
			this.Destroy()
		}
	}
}