with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Copier is

   procedure Create_Project (Project_Name : String; Template_Dir : String) is
      Project : constant Project_Type :=
        (Name_Length => Project_Name'Last, Name => Project_Name);
   begin
      Create_Directory_From_Template (Project, Project_Name, Template_Dir);
   end Create_Project;

   procedure Create_Directory_From_Template
     (Project          : Project_Type; Target_Directory : String;
      Source_Directory : String)
   is
      Search : Search_Type;
   begin
      Create_Directory (Target_Directory);

      Start_Search
        (Search => Search, Directory => Source_Directory, Pattern => "");
      while More_Entries (Search) loop
         declare
            Dir_Entry : Directory_Entry_Type;
         begin
            Get_Next_Entry (Search => Search, Directory_Entry => Dir_Entry);
            case Kind (Dir_Entry) is
               when Ordinary_File =>
                  declare
                     File_Name : constant String := Simple_Name (Dir_Entry);
                  begin
                     Translate_File
                       (Project, Input_Dir => Source_Directory,
                        Output_Dir         => Target_Directory,
                        File_Name          => File_Name);
                  end;
               when Directory =>
                  declare
                     Dir_Name : constant String := Simple_Name (Dir_Entry);
                  begin
                     if Dir_Name /= "." and Dir_Name /= ".." then
                        declare
                           New_Target_Dir : constant String :=
                             Target_Directory & "/" & Dir_Name;
                           New_Source_Dir : constant String :=
                             Source_Directory & "/" & Dir_Name;
                        begin
                           Create_Directory_From_Template
                             (Project, Target_Directory => New_Target_Dir,
                              Source_Directory          => New_Source_Dir);
                        end;
                     end if;
                  end;
               when Special_File =>
                  raise Project_Creation_Error
                    with "don't know what to do with special file " &
                    Source_Directory & "/" & Simple_Name (Dir_Entry);
            end case;
         end;
      end loop;
   end Create_Directory_From_Template;

   function Replace_Projectname
     (Project : Project_Type; Line : String) return String
   is
      PName_Begin : constant Natural := Index (Line, PName_Placeholder);
   begin
      if PName_Begin /= 0 then
         declare
            PName_End : constant Natural :=
              PName_Begin + PName_Placeholder'Length;
         begin
            return
              Replace_Slice (Line, PName_Begin, PName_End - 1, Project.Name);
         end;
      else
         return Line;
      end if;
   end Replace_Projectname;

   procedure Translate_File
     (Project   : Project_Type; Input_Dir : String; Output_Dir : String;
      File_Name : String)
   is
      Input_File      : Ada.Text_IO.File_Type;
      Output_File     : Ada.Text_IO.File_Type;
      Output_FileName : constant String :=
        Replace_Projectname (Project => Project, Line => File_Name);
   begin

      Open
        (File => Input_File, Mode => In_File,
         Name => Compose (Input_Dir, File_Name));
      Set_Input (Input_File);

      Create
        (File => Output_File, Mode => Out_File,
         Name => Compose (Output_Dir, Output_FileName));

      while not End_Of_File loop
         Put_Line (Output_File, Replace_Projectname (Project, Get_Line));
      end loop;

      Close (Output_File);
      Close (Input_File);

   end Translate_File;

end Copier;
