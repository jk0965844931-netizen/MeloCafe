#pragma once

namespace gui
{
	// Initialize the iOS GUI
	bool init();

	// Shutdown the iOS GUI
	void shutdown();

	// Main loop (iOS handles this differently)
	void mainLoop();

	// Update UI state
	void update();

	// Draw current frame
	void draw();

	// Get native window handle
	void* getNativeWindow();

	// Get native view handle
	void* getNativeView();

	// Check if GUI is initialized
	bool isInitialized();
}