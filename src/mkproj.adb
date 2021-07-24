with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Environment_Variables;

with Copier;

procedure Mkproj is
   Home          : constant String := Ada.Environment_Variables.Value ("HOME");
   Template_Root : constant String := Home & "/.config/mkproj/";
begin
   if Argument_Count /= 2 then
      Put_Line ("mkproj usage:");
      Put_Line ("mkproj project_template project_name");
      Put_Line
        ("e.g. mkproj project_templates/cpp_makefile my_foo_experiment");
      Set_Exit_Status (Failure);
      return;
   end if;
   declare
      Template_Dir : constant String := Template_Root & "/" & Argument (1);
   begin
      Copier.Create_Project
        (Project_Name => Argument (2), Template_Dir => Template_Dir);
   end;
end Mkproj;
