#setting up
COMPILER := cc
AR := ar
ALWAYS_ENABLED_FLAGS := -std=c99 -w
# just the ones that are extremely likely to be supported
COMMON_INSTRUCTIONS :=  -mmmx -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mcx16 -mavx -mpclmul
RELEASE_FLAGS :=  -Ofast $(COMMON_INSTRUCTIONS) $(ALWAYS_ENABLED_FLAGS)
CRAZY_FLAGS :=  -Ofast -march=native -flto

I := -Iinclude

ENKITS_SRC_DIR := _deps/enkits-src/src
GLFW_SRC_DIR := _deps/glfw-src/src
SRC_DIR := src
SRCS_DIRS := $(SRC_DIR)

OBJ_DIR := obj
LIB_DIR := lib

# finding all .c files and converting src/file.c to obj/file.o
C_FILES := $(foreach dir,$(SRCS_DIRS),$(wildcard $(dir)/*.c))
O_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(C_FILES))

LIB_OBJ := $(LIB_DIR)/box2d.o
LIB := $(LIB_DIR)/libbox2d.a

all: release_incremental

release_incremental: $(LIB)

$(LIB): $(O_FILES) $(LIB_DIR)
	$(AR) rs $(LIB) $(O_FILES) 

# actual compilation
$(OBJ_DIR)/%.o: $(OBJ_DIR)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(COMPILER) $(RELEASE_FLAGS) $(I) -MMD -MP -c $< -o $@
# "-" to not crash when not found
-include $(O_FILES:.o=.d)

# create directories
$(LIB_DIR):
	mkdir $(LIB_DIR)
$(OBJ_DIR):
	mkdir $(OBJ_DIR)

clean:
ifeq ($(OS),Windows_NT)
	-del /s /q $(OBJ_DIR) $(LIB_DIR)
else
	-rm -rf $(OBJ_DIR) $(LIB_DIR)
endif