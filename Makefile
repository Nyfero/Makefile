#    Colors
GREY = \e[90m
RED = \e[91m
GREEN = \e[92m
YELLOW = \e[93m
BLUE = \e[34m
PURPLE = \e[95m
CYAN = \e[96m
END = \e[39m

#    Showing command
DISP = FALSE

ifeq ($(DISP),TRUE)
    HIDE =
else
    HIDE = @
endif

#    Includes
INC = inc/

LIB_DIR = lib

LIB = $(LIB_DIR)/lib.a

#    Folders
SRCS_PATH = srcs

#    Files
FILES = main.c file_1.c \
	file_2.c

#    Compilation
NAME = a.out

CC = clang

CFLAGS = -Wall -Wextra -Werror

RM = rm -rf

SRCS = $(addprefix $(SRCS_PATH)/,	$(FILES))

OBJS_PATH = objs/

OBJS = $(patsubst $(SRCS_PATH)%.c,	$(OBJS_PATH)%.o,	$(SRCS))

#    Rules
all: $(NAME)

$(NAME): $(LIB) $(OBJS_PATH) $(OBJS) $(INC)/*.h
	@ echo "$(BLUE)\n         ***Make $(NAME) ***\n$(END)"
	$(HIDE) $(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(LIB)
	@ echo "$(GREEN)\n        ---$(NAME) created ---\n$(END)"

$(LIB): lib/Makefile
	@ echo "$(BLUE)\n        ***Make Lib ***\n$(END)"
	$(HIDE) make -C $(LIB_DIR)

$(OBJS_PATH):
	$(HIDE) mkdir -p $(OBJS_PATH)

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c $(INC)/*.h Makefile
	$(HIDE) $(CC) $(CFLAGS) -I $(INC) -c $< -o $@
	@ echo "$(GREEN)[ OK ]$(END) $(CYAN)${<:.s=.o}$(END)"

clean:
	$(HIDE) $(RM) $(OBJS_PATH)
	$(HIDE) make clean -C $(LIB_DIR)
	@ echo "$(PURPLE)\n        *** Clean objects ***\n$(END)"

fclean: clean
	$(HIDE) $(RM) $(NAME)
	$(HIDE) make fclean -C $(LIB_DIR)
	@ echo "$(RED)\n        *** Remove $(NAME) ***\n$(END)"

re: fclean all

.PHONY: all clean fclean re
