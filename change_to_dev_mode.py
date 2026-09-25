import json
import os

def enable_dev_mode():
    settings_path = "/content/ComfyUI/user/default/comfy.settings.json"

    # Ensure directory exists
    os.makedirs(os.path.dirname(settings_path), exist_ok=True)

    # Load or create settings
    if os.path.exists(settings_path):
        try:
            with open(settings_path, "r", encoding="utf-8") as f:
                settings = json.load(f)
        except Exception:
            print("Settings corrupted, recreating.")
            settings = {}
    else:
        settings = {}

    # Apply DevMode
    settings["Comfy.DevMode"] = True

    # Save
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(settings, f, indent=2)

    print("✔ DevMode enabled")

if __name__ == "__main__":
    enable_dev_mode()
