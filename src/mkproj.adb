with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with Copier;

procedure Mkproj is
   Template_Config_Root : constant String :=
     Containing_Directory
       (Containing_Directory (Containing_Directory (Command_Name)));
   -- TODO print the available template choices, then ask which is desired
   Template_Choice : constant String := "ada_makefile";
   Template_Dir    : constant String :=
     Compose
       (Compose (Template_Config_Root, "project_templates"), Template_Choice);
begin
   Put_Line ("The project will be created in: " & Current_Directory);
   Put ("Enter a name for the project: ");
   Copier.Create_Project
     (Project_Name => Get_Line, Template_Dir => Template_Dir);
end Mkproj;
