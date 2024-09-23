BUILD_DIR = build
CMAKE_FLAGS = -DBOX2D_BUILD_DOCS=OFF

# Targets
.PHONY: all clean

all: $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake $(CMAKE_FLAGS) .. && cmake --build . && cmake --install .

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)