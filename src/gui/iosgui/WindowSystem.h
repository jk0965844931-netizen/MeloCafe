#pragma once

// This is a minimal stub for the WindowSystem interface
// on iOS where wxWidgets is not available

#include <string>

namespace WindowSystem
{
	enum class WindowPosition
	{
		Center,
		TopLeft,
		TopRight,
		BottomLeft,
		BottomRight,
		Custom
	};

	inline void minimizeWindow() {}
	inline void maximizeWindow() {}
	inline void restoreWindow() {}
	inline void closeWindow() {}
	inline bool isMaximized() { return false; }
	inline bool isMinimized() { return false; }
	inline bool isActiveWindow() { return true; }

	inline void setWindowPosition(WindowPosition pos, int x = 0, int y = 0) {}
	inline void getWindowPosition(int* x, int* y) { if (x) *x = 0; if (y) *y = 0; }

	inline void setWindowSize(int width, int height) {}
	inline void getWindowSize(int* width, int* height) { if (width) *width = 1280; if (height) *height = 720; }

	inline void setWindowFocus(bool focus) {}
	inline bool hasWindowFocus() { return true; }

	inline void setWindowFullscreen(bool fullscreen) {}
	inline bool isWindowFullscreen() { return false; }

	inline void setWindowTitle(const std::string& title) {}
	inline std::string getWindowTitle() { return "MeloCafe"; }

	inline void sleep_ms(uint64_t ms) {}
}