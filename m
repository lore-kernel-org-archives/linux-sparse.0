From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Print function, return type, arguments and their types
Date: Fri, 22 Jun 2012 15:01:56 +0530
Message-ID: <CABG-yt3YWFp96jrrG0VmkDw+g-ABs45nR9i2bXer9Ao5dT4U9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35074 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761865Ab2FVJb5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Jun 2012 05:31:57 -0400
Received: by wibhn6 with SMTP id hn6so467577wib.1
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jun 2012 02:31:56 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I am trying to use sparse to obtain function return types,
arguments and their types. I modified test-inspect.c to use:

=== CODE SNIPPET ===

static void expand_symbols(struct symbol_list *list)
{
  struct symbol *sym, *base_type, *arg;

  FOR_EACH_PTR(list, sym) {

    printf("function: %s\n", sym->ident->name);

    printf("type: %s\n", show_typename(sym->ctype.base_type));

    base_type = get_base_type(sym);

    printf("arguments: \n");

    FOR_EACH_PTR_NOTAG(base_type->arguments, arg) {

      printf ("%s %s\n", show_typename(arg->ctype.base_type), arg->ident->name);

    } END_FOR_EACH_PTR_NOTAG(arg);

  } END_FOR_EACH_PTR(sym);

}

=== END ===

I also made the following changes:

=== expand.c ===

@@ -1038,8 +1038,11 @@ int expand_symbol(struct symbol *sym)
 	retval = expand_expression(sym->initializer);
 	/* expand the body of the symbol */
 	if (base_type->type == SYM_FN) {
-		if (base_type->stmt)
+	  if (base_type->stmt) {
+	    if (base_type->stmt->declaration) {
 			expand_statement(base_type->stmt);
+	    }
+	  }

=== END ===

I have also commented out printing "( ... )" in case of a function
in show-parse.c:

=== show-parse.c ===

 	case SYM_FN:
-		if (was_ptr) {
+	  /* if (was_ptr) {
 			prepend(name, "( ");
 			append(name, " )");
 			was_ptr = 0;
 		}
-		append(name, "( ... )");
+		append(name, "( ... )"); */
 		break;

=== END ===

#1 The above code and changes does display a function name, its
 return type, list of arguments and their types. Are these
 correct, or are there better ways to do it without modifying the
 core files?

#2 The above changes also displays global arrays in the
 output (if they exist). For example, if I had:

  const char bar[] = "hello";

It displays:

  function: bar
  type: char const [0]
  arguments:

What can be done to only parse functions and not global arrays?

#3 For some data types, "[usertype]" or "[0]", as in the above
 example, gets appended. How can I ensure that these are
 not emitted in the output?

Appreciate any inputs in this regard.

Thanks!

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
