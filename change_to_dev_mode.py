import json
import os

def enable_dev_mode():
    # Path inside ComfyUI
    settings_path = os.path.join("user", "default", "comfy.settings.json")

    # Ensure directory exists
    os.makedirs(os.path.dirname(settings_path), exist_ok=True)

    # Load existing settings or create new
    if os.path.exists(settings_path):
        try:
            with open(settings_path, "r", encoding="utf-8") as f:
                settings = json.load(f)
        except Exception:
            print("Warning: settings file corrupted, recreating.")
            settings = {}
    else:
        settings = {}

    # Apply patch
    settings["Comfy.DevMode"] = True

    # Save back
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(settings, f, indent=2)

    print("✔ DevMode enabled in comfy.settings.json")

if __name__ == "__main__":
    enable_dev_mode()





python change_to_dev_mode.py
