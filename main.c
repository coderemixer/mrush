#include <stdio.h>
#include <mruby.h>
#include "mruby/compile.h"

int main() {
    mrb_state *mrb = mrb_open();
    printf("mrush> ");
    mrb_load_string(mrb, "puts 'Hello World!'");
    mrb_close(mrb);
    return 0;
}
