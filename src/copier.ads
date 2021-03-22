package Copier is

   Project_Creation_Error : exception;
   procedure Create_Project (Project_Name : String; Template_Dir : String);

private

   PName_Placeholder : constant String := "__PROJECTNAME__";

   type Project_Type (Name_Length : Positive) is record
      Name : String (1 .. Name_Length);
   end record;

   procedure Create_Directory_From_Template
     (Project          : Project_Type; Target_Directory : String;
      Source_Directory : String);

   function Replace_Projectname
     (Project : Project_Type; Line : String) return String;

   procedure Translate_File
     (Project   : Project_Type; Input_Dir : String; Output_Dir : String;
      File_Name : String);

end Copier;
