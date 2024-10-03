BUILD_DIR = build
CMAKE_FLAGS = -DBOX2D_BUILD_DOCS=OFF -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles"

.PHONY: all clean

all: $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake $(CMAKE_FLAGS) .. && cmake --build . --config Release && cmake --install .

$(BUILD_DIR):
ifeq ($(OS),Windows_NT)
	mkdir $(BUILD_DIR)
else
	mkdir -p $(BUILD_DIR)
endif

clean: $(BUILD_DIR)
ifeq ($(OS),Windows_NT)
	-del /s /q "build" 
else
	-rm -R $(BUILD_DIR)*
endif