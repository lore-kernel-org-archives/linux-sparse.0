From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 13/15] Gdb macros to get a better look at some sparse data
	structures.
Date: Mon, 15 Dec 2008 03:27:38 +0300
Message-ID: <20081215002738.16107.73664.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:27597 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYLOAS1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:18:27 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1362078fkq.5
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:18:25 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Note that we need to build sparse with -g3 -gdwarf-2 to get
the cpp macros included into the debug ingo.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile   |   20 ++--
 gdbhelpers |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 321 insertions(+), 9 deletions(-)
 create mode 100644 gdbhelpers

diff --git a/Makefile b/Makefile
index 3eab17e..ca33218 100644
--- a/Makefile
+++ b/Makefile
@@ -1,19 +1,21 @@
 VERSION=0.4.1
 
-OS ?= linux
+OS = linux
 
-CC ?= gcc
-CFLAGS ?= -O2 -finline-functions -fno-strict-aliasing -g
-CFLAGS += -Wall -Wwrite-strings
-LDFLAGS ?= -g
-AR ?= ar
 
-HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
+CC = gcc
+CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+CFLAGS += -Wall -Wwrite-strings
+LDFLAGS += -g
+AR = ar
 
 #
 # For debugging, uncomment the next one
 #
-CFLAGS += -DDEBUG
+#CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
+
+HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
+
 
 DESTDIR=
 PREFIX=$(HOME)
@@ -191,7 +193,7 @@ pre-process.h:
 	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
 
 clean: clean-check
-	rm -f *.[oa] $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f *.[oa] *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
 
 dist:
 	@if test "`git describe`" != "$(VERSION)" ; then \
diff --git a/gdbhelpers b/gdbhelpers
new file mode 100644
index 0000000..7223ffd
--- /dev/null
+++ b/gdbhelpers
@@ -0,0 +1,310 @@
+
+# Don't forget to rebuild sparse with uncommented debug options
+# in the Makefile. Also, gcc 3 is known to screw up with the
+# cpp macros in the debugging info.
+
+
+# If a gdb_show_* function is running at a non-zero recursion
+# level, only a short summary is shown, preventing further
+# recursion. Also note that gdb has only one, global, scope
+# for variables, so we need to be careful with recursions.
+
+
+set $showing_token = 0
+set $showing_ident = 0
+set $showing_symbol = 0
+
+set $ntabs = 0
+
+define gdb_tabs
+	set $tmp = $ntabs
+	while ($tmp--)
+		printf "\t"
+	end
+end
+
+
+# Ptr list handling
+define ptr_entry
+	set $ptr = $arg0
+	set $index = $arg1
+	set $entry = &($arg2)
+
+	set *($entry) = (void *) (~3UL & (unsigned long)$ptr->list[$index])
+end
+
+
+# Ptr list looping skeleton
+define gdb_ptr_list_for_each
+
+	set $my_head = (struct ptr_list *) $arg0
+	set $my_list = $my_head
+
+
+	if ($my_head)
+		while (1)
+			set $my_nr = 0
+			while ($my_nr < $my_list->nr)
+
+				# Put your iterator code here
+				set $my_nr++
+			end
+
+			if (($my_list = $my_list->next) == $my_head)
+				loop_break
+			end
+		end
+	end
+end
+
+# Show symbols in a symbol_list. Non-recursive
+define gdb_ptr_list_for_each_show_symbol
+
+	set $my_head = (struct ptr_list *) $arg0
+	set $my_list = $my_head
+
+
+	if ($my_head)
+		while (1)
+			set $my_nr = 0
+			while ($my_nr < ($my_list)->nr)
+				set $my_symbol = (struct symbol *) ((~3UL) & (unsigned long)($my_list)->list[$my_nr])
+				gdb_show_symbol($my_symbol)
+
+				set $my_nr++
+			end
+
+			set $my_list = ($my_list)->next
+			if ($my_list == $my_head)
+				loop_break
+			end
+		end
+	end
+end
+
+
+#define gdb_show_statement
+
+
+# Recursive
+define gdb_show_ctype
+	printf "modifiers: "
+	if ($arg0->modifiers & MOD_AUTO)
+		printf "MOD_AUTO "
+	end
+	if ($arg0->modifiers & MOD_REGISTER)
+		printf "MOD_REGISTER "
+	end
+	if ($arg0->modifiers & MOD_STATIC)
+		printf "MOD_STATIC "
+	end
+	if ($arg0->modifiers & MOD_EXTERN)
+		printf "MOD_EXTERN "
+	end
+	if ($arg0->modifiers & MOD_CONST)
+		printf "MOD_CONST "
+	end
+	if ($arg0->modifiers & MOD_VOLATILE)
+		printf "MOD_VOLATILE "
+	end
+	if ($arg0->modifiers & MOD_SIGNED)
+		printf "MOD_SIGNED "
+	end
+	if ($arg0->modifiers & MOD_UNSIGNED)
+		printf "MOD_UNSIGNED "
+	end
+	if ($arg0->modifiers & MOD_CHAR)
+		printf "MOD_CHAR "
+	end
+	if ($arg0->modifiers & MOD_SHORT)
+		printf "MOD_SHORT "
+	end
+	if ($arg0->modifiers & MOD_LONG)
+		printf "MOD_LONG "
+	end
+	if ($arg0->modifiers & MOD_LONGLONG)
+		printf "MOD_LONGLONG "
+	end
+	if ($arg0->modifiers & MOD_TYPEDEF)
+		printf "MOD_TYPEDEF "
+	end
+	if ($arg0->modifiers & MOD_INLINE)
+		printf "MOD_INLINE "
+	end
+	if ($arg0->modifiers & MOD_ADDRESSABLE)
+		printf "MOD_ADDRESSABLE "
+	end
+	if ($arg0->modifiers & MOD_NOCAST)
+		printf "MOD_NOCAST "
+	end
+	if ($arg0->modifiers & MOD_NODEREF)
+		printf "MOD_NODEREF "
+	end
+	if ($arg0->modifiers & MOD_ACCESSED)
+		printf "MOD_ACCESSED "
+	end
+	if ($arg0->modifiers & MOD_TOPLEVEL)
+		printf "MOD_TOPLEVEL "
+	end
+	if ($arg0->modifiers & MOD_LABEL)
+		printf "MOD_LABEL "
+	end
+	if ($arg0->modifiers & MOD_ASSIGNED)
+		printf "MOD_ASSIGNED "
+	end
+	if ($arg0->modifiers & MOD_TYPE)
+		printf "MOD_TYPE "
+	end
+	if ($arg0->modifiers & MOD_SAFE)
+		printf "MOD_SAFE "
+	end
+	if ($arg0->modifiers & MOD_USERTYPE)
+		printf "MOD_USERTYPE "
+	end
+	if ($arg0->modifiers & MOD_FORCE)
+		printf "MOD_FORCE "
+	end
+	if ($arg0->modifiers & MOD_EXPLICITLY_SIGNED)
+		printf "MOD_EXPLICITLY_SIGNED"
+	end
+	if ($arg0->modifiers & MOD_BITWISE)
+		printf "MOD_BITWISE "
+	end
+	if (!$arg0->modifiers)
+		printf "0"
+	end
+
+	printf ", alignment = %d", $arg0->alignment
+	if ($arg0->as)
+		printf ", address_space = %d", $arg0->as
+	end
+	printf "\n"
+
+
+	set $ntabs++
+	if ($arg0->base_type)
+		gdb_tabs
+		printf "base_type = "
+		gdb_show_symbol($arg0->base_type)
+	end
+
+	set $ntabs--
+
+
+end
+
+define gdb_show_symbol
+	printf "(%x) type = ", $arg0
+	output $arg0->type
+	printf ", namespace = "
+	output $arg0->namespace
+	if ($arg0->ident)
+		printf ", ident = %s\n", show_ident($arg0->ident)
+	else
+		printf ", ident = NULL\n"
+	end
+
+#	print "zz"
+
+	gdb_tabs
+	printf "dump:\n"
+	call show_symbol($arg0)
+
+	set $ntabs++
+	if ($arg0->namespace == NS_SYMBOL)
+		gdb_tabs
+		printf "ctype = "
+		gdb_show_ctype(&($arg0->ctype))
+	end
+	set $ntabs--
+end
+
+
+# non-recursive
+define gdb_show_symbols_next_id
+	set $sym = $arg0
+	printf "{\n"
+	set $ntabs++
+	while ($sym)
+		gdb_tabs
+		printf "symbol = "
+		gdb_show_symbol($sym)
+		set $sym = $sym->next_id
+	end
+	set $ntabs--
+	gdb_tabs
+	printf "}\n"
+end
+
+define gdb_show_ident
+	if ($arg0)
+		printf "(%p) '%s'\n", $arg0, show_ident($arg0)
+	else
+		printf "NULL\n"
+	end
+
+	if (! $showing_ident)
+		set $showing_ident = 1
+		set $ntabs++
+
+		set $ident = $arg0
+
+		if ($ident->symbols)
+			gdb_tabs
+			printf "symbols = "
+			gdb_show_symbols_next_id($ident->symbols)
+		end
+
+		set $ntabs--
+		set $showing_ident = 0
+	end
+end
+
+define gdb_show_token
+	printf "%p: '%s', type = ", $arg0, show_token($arg0)
+	output (enum token_type) ($arg0)->pos.type
+	printf "\n"
+
+	if (! $showing_token)
+		set $showing_token = 1
+		set $ntabs++
+
+		set $token = $arg0
+
+		if ($token->pos.type == TOKEN_IDENT)
+			gdb_tabs
+			printf "ident = "
+			gdb_show_ident $token.ident
+		end
+
+		if ($token->pos.type == TOKEN_MACRO_ARGUMENT)
+			gdb_tabs
+			printf "argnum = %d\n", $token->argnum
+		end
+
+		if ($token->pos.type == TOKEN_SPECIAL)
+			gdb_tabs
+			printf "special = \"%s\"\n", show_special($token.special)
+		end
+
+		set $ntabs--
+		set $showing_token = 0
+	end
+end
+
+# non-recursive
+define gdb_show_tokens
+	set $t = $arg0
+	printf "{\n"
+	set $ntabs++
+	while ($t != &eof_token_entry)
+		gdb_tabs
+		printf "token = "
+		gdb_show_token($t)
+		set $t = ($t)->next
+	end
+	set $ntabs--
+	gdb_tabs
+	printf "}\n"
+end
+

