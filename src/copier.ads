package Copier is

   Project_Creation_Error : exception;
   procedure Create_Project (Project_Name : String; Template_Dir : String);

private

   PName_Placeholder : constant String := "__PROJECTNAME__";

   procedure Create_Directory_From_Template
     (Project_Name     : String; Target_Directory : String;
      Source_Directory : String);

   function Replace_Projectname
     (Project_Name : String; Line : String) return String;

   procedure Translate_File
     (Project_Name : String; Input_Dir : String; Output_Dir : String;
      File_Name    : String);

end Copier;
