class MainWindow extends CGUI
{
	logoFile := ""

	; picture
	picLogo		:= this.AddControl("Picture", "picLogo", "w200 h220 x5 y5 border cRed")

	; labels:
	labelName			:= this.AddControl("Text", "labelName",			"w100 x210 y15",		"Name:")
	labelType			:= this.AddControl("Text", "labelType",			"w100 xp yp+30",		"Type:")
	labelGUID			:= this.AddControl("Text", "labelGUID",			"w100 xp yp+30",		"Unique ID:")
	labelVersion		:= this.AddControl("Text", "labelVersion",		"w100 xp yp+30",		"Version:")
	labelDescription	:= this.AddControl("Text", "labelDescription",	"w100 xp yp+30",		"Description:")
	labelAuthors		:= this.AddControl("Text", "labelAuthors",		"w100 xp+550 yp-120",	"Authors:")
	labelDependencies	:= this.AddControl("Text", "labelDependencies",	"w100 xp yp+180",		"Dependencies:")
	labelTags			:= this.AddControl("Text", "labelTags",			"w100 xp yp+180",		"Tags:")
	labelLinks			:= this.AddControl("Text", "labelLinks",		"w100 xp yp+180",		"Links:")
	labelRequirements	:= this.AddControl("Text", "labelRequirements",	"w100 xp yp+180",		"Requirements:")
	labelSrcFiles		:= this.AddControl("Text", "labelSrcFiles",		"w100 x10 y250",		"Source files:")
	labelDocFiles		:= this.AddControl("Text", "labelDocFiles",		"w100 xp yp+230",		"Documentation files:")

	; info:
	infoGUID := this.AddControl("Edit", "infoGUID", "x310 y75 w400 readonly")

	; input:
	inputName		:= this.AddControl("Edit",	"inputName",		"x310 y15 w400")
	inputTypeLib	:= this.AddControl("Radio",	"inputTypeLib",		"xp yp+30 w100 checked",	"Library")
	inputTypeApp	:= this.AddControl("Radio",	"inputTypeApp",		"xp+105 yp w100",			"Application")
	inputVerMajor	:= this.AddControl("Edit",	"inputVerMajor",	"xp-105 y105 w80")
		init_inputVerMajor := this.inputVerMajor.AddUpdown(0, 1000)
	inputVerMinor	:= this.AddControl("Edit",	"inputVerMinor",	"xp+80 yp w80")
		init_inputVerMinor := this.inputVerMinor.AddUpdown(0, 1000)
	inputVerUpdate	:= this.AddControl("Edit",	"inputVerUpdate",	"xp+80 yp w80")
		init_inputVerUpdate := this.inputVerUpdate.AddUpdown(0, 1000)
	inputVerBugfix	:= this.AddControl("Edit",	"inputVerBugfix",	"xp+80 yp w80")
		init_inputVerBugfix := this.inputVerBugfix.AddUpdown(0, 1000)
	inputVerExtra	:= this.AddControl("Edit",	"inputVerExtra",	"xp+80 yp w80")
	inputDescription:= this.AddControl("Edit",	"inputDescription",	"xp-320 yp+30 w400 r6")

	; lists:
	listAuthors			:= this.AddControl("ListView", "listAuthors",		"w490 h125 x745 y40",	"name|user name|homepage|email")
	listDependencies	:= this.AddControl("ListView", "listDependencies",	"wp hp xp yp+180",		"name|version|id")
	listTags			:= this.AddControl("ListView", "listTags",			"wp hp xp yp+180",		"tag")
	listLinks			:= this.AddControl("ListView", "listLinks",			"wp hp xp yp+180",		"name|description|URL")
	listRequirements	:= this.AddControl("ListView", "listRequirements",	"wp hp xp yp+180",		"type|value")
	listSrcFiles		:= this.AddControl("ListView", "listSrcFiles",		"w700 h175 x10 y275",	"file name|path")
	listDocFiles		:= this.AddControl("ListView", "listDocFiles",		"wp hp xp yp+230",		"file name|path")

	; add buttons:
	addAuthors		:= this.AddControl("Button", "addAuthors",		"w245 x745 y165",	"Add")
	addDependencies	:= this.AddControl("Button", "addDependencies",	"wp xp yp+180",		"Add")
	addTags			:= this.AddControl("Button", "addTags",			"wp xp yp+180",		"Add")
	addLinks		:= this.AddControl("Button", "addLinks",		"wp xp yp+180",		"Add")
	addRequirements	:= this.AddControl("Button", "addRequirements",	"wp xp yp+180",		"Add")
	addSrcFiles		:= this.AddControl("Button", "addSrcFiles",		"w350 x10 y450",	"Add")
	addDocFiles		:= this.AddControl("Button", "addDocFiles",		"wp xp yp+230",		"Add")

	; remove buttons:
	removeAuthors		:= this.AddControl("Button", "removeAuthors",		"w245 x990 y165",	"Remove")
	removeDependencies	:= this.AddControl("Button", "removeDependencies",	"wp xp yp+180",		"Remove")
	removeTags			:= this.AddControl("Button", "removeTags",			"wp xp yp+180",		"Remove")
	removeLinks			:= this.AddControl("Button", "removeLinks",			"wp xp yp+180",		"Remove")
	removeRequirements	:= this.AddControl("Button", "removeRequirements",	"wp xp yp+180",		"Remove")
	removeSrcFiles		:= this.AddControl("Button", "removeSrcFiles",		"w350 x360 y450",	"Remove")
	removeDocFiles		:= this.AddControl("Button", "removeDocFiles",		"wp xp yp+230",		"Remove")

	; cancel/OK:
	generateCancel	:= this.AddControl("Button", "generateCancel",	"w245 h40 x280 y795",	"Cancel")
	generateDef		:= this.AddControl("Button", "generateDef",		"wp hp x280 yp+45",		"Generate definition")
	generatePack	:= this.AddControl("Button", "generatePack",	"wp hp x280 yp+45",		"Generate package")

	; settings:
	DestroyOnClose := true
	Title := "UUO definition file generator"
	MaximizeBox := true
	WindowColor := "0xE1EBFF"

	__New()
	{
		GUID_Create(guid), this.infoGUID.Text := GUID_ToString(&guid)
	}

	generateCancel_Click()
	{
		this.Destroy()
	}

	generateDef_Click()
	{
		file := "test.adl" ; todo

		this.GenerateDefinitionFile(file)

		MsgBox 4, Ununoctium, Saved definition to %file%. Open containing directory?
		IfMsgBox, Yes
		{
			SplitPath file,, dir
			Run %dir%
		}
	}

	generatePack_Click()
	{
		file := "test.adl" ; todo
		outFile := "test.zip"

		this.GenerateDefinitionFile(file)

		_wd := A_WorkingDir
		SetWorkingDir % this.RootDir

		pack := new ALD.PackageGenerator(file)
		pack.Package(outFile)

		SetWorkingDir %_wd%

		MsgBox 4, Package created at %file%. Open containing directory?
		IfMsgBox, Yes
		{
			SplitPath file,, dir
			Run %dir%
		}
	}

	GenerateDefinitionFile(file)
	{
		obj := new ALD.DefinitionGenerator()
		, obj.Name := this.inputName.Text
		, obj.GUID := this.infoGUID.Text
		, obj.Description := this.inputDescription.Text
		, obj.LogoFile := this.logoFile

		_type := this.inputTypeApp.GetSelectedRadioButton()
		if (_type == this.inputTypeApp)
			obj.Type := "app"
		else
			obj.Type := "lib"

		_version := ""
		for each, field in ["Major", "Minor", "Update", "Bugfix"]
		{
			if (this["inputVer" . field].Text == "")
				break
			_version .= ((A_Index == 1) ? "" : ".") . this["inputVer" . field].Text
		}
		if (this.inputVerExtra.Text != "")
			_version .= (_version == "" ? "" : A_Space) . this.inputVerExtra.Text
		obj.Version := _version

		Loop % this.listAuthors.Items.Count
		{
			row := this.listAuthors.Items[A_Index]
			author := { "name" : row[1] }
			if (row[2] != "")
				author["user-name"] := row[2]
			if (row[3] != "")
				author["homepage"] := row[3]
			if (row[4] != "")
				author["email"] := row[4]
			obj.Authors.Insert(author)
		}
		for each, row in this.listDependencies.Items
		{
			; todo!
		}
		for each, row in this.listRequirements.Items
		{
			; todo!
		}
		for each, row in this.listSrcFiles.Items
		{
			obj.SrcFiles.Insert({ "path" : row[1] })
		}
		for each, row in this.listDocFiles.Items
		{
			obj.DocFiles.Insert({ "path" : row[1] })
		}
		for each, row in this.listTags.Items
		{
			obj.Tags.Insert({ "name" : row[1] })
		}
		for each, row in this.listLinks.Items
		{
			obj.Links.Insert({ "name" : row[1], "description" : row[2], "href" : row[3] })
		}

		obj.Write()
		obj.SaveToFile(file)
	}

	; handlers:
	PostDestroy()
	{
		ExitApp
	}

	picLogo_Click()
	{
		FileSelectFile logo, 3, % this.RootDir, Select the package logo, Images (*.jpg; *.jpeg; *.bmp; *.png; *.ico; *.cur; *.ani; *.scr; *.gif; *.tif; *.exif; *.wmf; *.emf)
		if (ErrorLevel || !logo)
			return
		this.logoFile := this.picLogo.Picture := logo
	}

	addAuthors_Click()
	{
		dialog := new AuthorDialog(new Delegate(this, "onAuthorCreated"))
		dialog.Owner := this.hwnd
		dialog.Show()
	}

	onAuthorCreated(name, user, mail, url)
	{
		this.listAuthors.Items.Add("", name, user, mail, url)
	}

	removeAuthors_Click()
	{
		this.removeSelectedListItems(this.listAuthors)
	}

	addSrcFiles_Click()
	{
		this.addFiles(this.listSrcFiles)
	}

	addDocFiles_Click()
	{
		this.addFiles(this.listDocFiles)
	}

	removeSrcFiles_Click()
	{
		this.removeSelectedListItems(this.listSrcFiles)
	}

	removeDocFiles_Click()
	{
		this.removeSelectedListItems(this.listDocFiles)
	}

	addFiles(list)
	{
		FileSelectFile files, M3, % this.RootDir, Select the new file(s) to add.
		if (!ErrorLevel && files != "")
		{
			Loop parse, files, `n
			{
				if (A_Index == 1)
				{
					if (this.RootDir != A_LoopField) ; todo!
						root := A_LoopField . "\"
					continue
				}
				
				list.Items.Add("", root . A_LoopField)
			}
		}
		this.shortenFilePaths()
	}

	shortenFilePaths()
	{
		for each, row in this.listSrcFiles.Items
		{
			if (InStr(row[1], this.RootDir) == 1) ; starts with root dir
			{
				row[1] := SubStr(row[1], StrLen(this.RootDir) + 2, StrLen(row[1]))
			}
		}
		for each, row in this.listDocFiles.Items
		{
			if (InStr(row[1], this.RootDir) == 1) ; starts with root dir
			{
				row[1] := SubStr(row[1], StrLen(this.RootDir) + 2, StrLen(row[1]))
			}
		}
	}

	addTags_Click()
	{
		InputBox tag, Add a new tag, Enter the name of the new tag...
		if (!ErrorLevel && tag != "")
		{
			; search if already included
			for each, row in this.listTags.Items
			{
				if (row[1] = tag)
				{
					this.listTags.SelectedItem := row
					return
				}
			}
			this.listTags.Items.Add("", tag)
		}
	}

	removeTags_Click()
	{
		this.removeSelectedListItems(this.listTags)
	}

	removeSelectedListItems(list)
	{
		for each, item in list.SelectedItems
		{
			list.Items.Delete(item)
		}
	}
}