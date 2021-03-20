with Ada.Text_IO;	      use Ada.Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Mkproj is
   Template_Config_Root : constant String := Containing_Directory(Containing_Directory(Containing_Directory(Command_Name)));
   -- TODO print the available template choices, then ask which is desired
   Template_Choice : constant String := "ada_makefile";
   Template_Dir : constant String := Compose(Compose(Template_Config_Root, "templates"), Template_Choice);
   PName_Placeholder : constant String := "__PROJECTNAME__";
begin

	Put_Line ("The project will be created in: " & current_directory);
   Put ("Enter a name for the project: ");

   declare
	   Project_Name : String := Get_Line;

      procedure Translate_File (Output_Dir : String; File_Name : String) is
	      Input_File : Ada.Text_IO.File_Type;
	      Output_File : Ada.Text_IO.File_Type;

         function Replace_Projectname (Line : String) return String is
	         PName_Begin : Natural := Index(line, PName_Placeholder);
         begin
	         if PName_Begin /= 0 then
	            declare
	               PName_End : Natural := PName_Begin + PName_Placeholder'Length;
	            begin
		            return Replace_Slice (Line,PName_Begin,PName_End-1,Project_Name);
	            end;
	         else
	            return Line;
	         end if;
	      end Replace_Projectname;

         Output_FileName : String := Replace_Projectname (File_Name);
      begin -- Translate_File

	      Open (File => Input_File,
			      Mode => In_File,
			      Name => Compose (Template_Dir, File_Name));
			Set_Input (Input_File);

	      Create (File => Output_File,
	  			     Mode => Out_File,
	  			     Name => Compose (Output_Dir, Output_FileName));

	      while not End_Of_File loop
	         Put_Line (Output_File, Replace_Projectname (Get_Line));
	      end loop;

	      Close (Output_File);
	      Close (Input_File);

      end Translate_File;
	begin
	   Create_Directory (Project_Name);

      declare
         Search : Search_Type;
      begin
         Start_Search (Search    => Search, 
                       Directory => Template_Dir,
                       Pattern   => "");
         while More_Entries (Search) loop
            declare
               Dir_Entry : Directory_Entry_Type;
            begin
               Get_Next_Entry (Search          => Search,
                               Directory_Entry => Dir_Entry );
               if Kind (Dir_Entry) = Ordinary_File then
                  declare
                     File_Name : String := Simple_Name (Dir_Entry);
                  begin
	                  Translate_File (Output_Dir => Project_Name, File_Name => File_Name );
	               end;
               end if;
            end;
         end loop;
      end;
   end;
end Mkproj;
