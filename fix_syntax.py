import os
import re

files_with_bottom_nav = [
    "lib/feature/training/view/add_training_screen.dart",
    "lib/feature/recovery/view/recovery_checkin_screen.dart",
    "lib/feature/calendar/view/add_event_screen.dart",
    "lib/feature/profile/view/edit_profile_screen.dart",
    "lib/feature/profile/view/change_password_screen.dart",
    "lib/feature/profile/view/privacy_policy_screen.dart",
    "lib/feature/profile/view/terms_conditions_screen.dart",
    "lib/feature/profile/view/settings_privacy_screen.dart"
]

for file in files_with_bottom_nav:
    path = os.path.join(".", file)
    if not os.path.exists(path): continue
    with open(path, "r") as f:
        content = f.read()
    
    # regex to fix the bottom nav
    # from:
    #       ),
    #       bottomNavigationBar: const BottomNavBar(activeIndex: X),
    #     ));
    #   }
    
    pattern = re.compile(r"(\s+)\),\n\s+bottomNavigationBar: const BottomNavBar\((.*?)\),\n\s+\)\);\n\s+\}")
    def repl1(m):
        return f"{m.group(1)}  bottomNavigationBar: const BottomNavBar({m.group(2)}),\n{m.group(1)}),\n{m.group(1)[:-2]});\n  }}"
    
    # Or simpler:
    content = re.sub(
        r"(\s+)\),\n\s+bottomNavigationBar:\s+(const BottomNavBar\([^)]+\)),\n\s+\)\);\n\s+\}",
        r"\n\1  bottomNavigationBar: \2,\n\1),\n    );\n  }",
        content
    )
    
    with open(path, "w") as f:
        f.write(content)

files_without_bottom_nav = [
    "lib/feature/home/view/home_screen.dart",
    "lib/feature/training/view/training_screen.dart",
    "lib/feature/calendar/view/calendar_screen.dart",
    "lib/feature/recovery/view/recovery_screen.dart",
    "lib/feature/profile/view/profile_screen.dart"
]

for file in files_without_bottom_nav:
    path = os.path.join(".", file)
    if not os.path.exists(path): continue
    with open(path, "r") as f:
        content = f.read()
    
    # replace 3 closing brackets with 2, or just fix the specific extra bracket
    #         ),
    #         ),
    #       ),
    #     );
    #   }
    content = re.sub(
        r"\s+\),\n(\s+)\),\n(\s+)\),\n(\s+)\);\n(\s+)\}",
        r"\n\1),\n\2),\n\3);\n\4}",
        content
    )
    
    with open(path, "w") as f:
        f.write(content)

print("Fixed syntax in all files")
