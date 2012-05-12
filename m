From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Sat, 12 May 2012 19:46:48 +0200
Message-ID: <4FAEA208.3090601@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com> <4FA5B9E8.7010208@gmail.com> <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com> <4FA767BD.8060703@gaisler.com> <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com> <4FA8BF7D.60606@gaisler.com> <CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com> <4FAA3D50.8080901@gaisler.com> <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com> <4FAB5DEA.5060009@gaisler.com> <4FAB6268.7070908@gaisler.com> <CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com> <4FAB8F9E.8040205@gaisler.com> <CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com> <4FABB132.1070308@gmail.com> <4FABB467.7030703@gmail.com> <CANe
 U7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com> <4FAD892B.8070709@gmail.com> <CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020101020406000100050005"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38353 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2ELRnP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 12 May 2012 13:43:15 -0400
Received: by lbbgm6 with SMTP id gm6so2540106lbb.19
        for <linux-sparse@vger.kernel.org>; Sat, 12 May 2012 10:43:13 -0700 (PDT)
In-Reply-To: <CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020101020406000100050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2012 01:02 PM, Christopher Li wrote:
> On Fri, May 11, 2012 at 2:48 PM, Konrad Eisele<eiselekd@gmail.com>  wrote:
>>
>> This seems ok. expanding_macro has to be global not static to be
>> used... (?)
>
> The expand_macro call back use the parent argument which get
> from expanding_macro list. The caller should be able to create tree
> from the leaf node using the parent pointer.
>
> Feel free to change to use the expanding_macro instead if that make
> building the tree easier.
>
>> I think the fact that argument expansion is recursive and
>> body expansion is non-recursive is one of the things that
>> make the preprocessor kindof hard to grasp.
>
> The body expansion can't be recursive on same macro  otherwise
> it can result in unlimited expansion. The C stander specify
> the macro expand this way.
>
>>
>> I cannot say this before I've tried it.
>>
>> I'd like to straighten things out a bit: My last emails
>> where a bit too harsh and I'd like to apologize. Sorry
>> for that.
>
> No problem at all. I figure you just want to the patch to
> get included.
>
>> The next step then is: I'll write a patch to add a
>> test-prog that uses this api to trace the token generation
>> and generate a tree for it.
>> For a start I'll printout for all tokens of a preprocessor
>> run all macros-expansions that generated them.
>
> That is great. I have a test-macro program in that
> branch which is very close to print out all the tokens.

Appended is a test-patch that adds test-mdep testcase.
The file mdep.c is used to record that macro
expansion, each token will have a reference to its
source.
test-mdep.c does pre-process (as test-macro.c) then
prints out the token trace through macros for each
token: @{ } is used to mark the active path.

An example file is added: a.h
$test-mdep a.h
...
0004: 8
      body in D1 :4 @{8} 10 9 5 <untaint: D1>
      arg0 in D1 :@{8} 10 9
      body in D0 :1 @{D1}(8 10 9) 2 D2(11) 3 <untaint: D0>
      a.h:6:6
...
Token nr 4 of the preprocess stream is "8". The
generation path of "8" is marked @{8}...
Not 100%, still, I think already readable. (Actually
the printout order should be reversed (starting from file scope
and drilling down the macro expansions...)

I still dont handle empty expansions. I'll see weather I can come up 
with something here...


>
>> Now, I've learned not to run too fast towards the
>> goal, (which is still "dependency tee from c parser entities downto
>> token"), maybe you can think about how to achieve the next steps
>> in an API :
>> - An #include #ifdef #else #endif pushdown-stack
>>   to record the nestings for each token
>
> Let me think about this. Just thinking out lound,
> The #include and #ifdef can consider as a special kind
> of predefine macro as well.

No, only a linked list that model the nexting levels.
Then a preprocessor hook that can register lookup_macro()
macro lookups inside # preprocessor lines. An example
makes it clear:

#if defined(a) && defined(b)
#if defined(c)
#endif
#if defined(e)
#endif
#endif

Result in:
[a b]+<-[c]
      +<-[e]

This can be easily done with a push-pop brackets
and a callback in lookup_macro().


Also:
#if defined(a)
#elif defined(c)
#endif

[a]+<-[c]

#if defined(a)
#else
#endif

<-[empty]<-[a]

...


Another point I also need is to have an option so that inside
do_handle_define() the symbol structures are never reused but
alloc_symbol() is always used for undef and define, this is
because I need to be able to also track the undef and define
history for a macro at a certain position. I think this should be
easy to add because you just need to define define-undef on
top of each other...


>
>> - How to connect all this to the AST.
>
> For symbol, it relative easy because symbol has pos range
> and aux pointer.

I thought about taking "struct symbol_list *syms = sparse(file)"
as the root. Then mark all elements that are used by them as dependent.
I dont have enough insight to say how I can determine things like
  which "static inline" are used or how to traverse the
"typedef" dependency.
The goal is to have a "shrink" application that can strip away
all c-lines (pre-pre-process level) that are not used by a specific
command invocation of the compiler. Also a tool that can quickly show
for a specific identifier everything that is connected to it, again on
pre-preprocessor source level. kind-of something like:
...
func1() {
	struct string_list *filelist = NULL; int i;
}
..
I point to "string_list" and then all lines that are related
to struct string_list, (#ifdef nestings, macros, all member typedefs)
etc are shown and all the rest stripped away, again on human
readable c source level.


>
> Do you need to attach the dependency for the statment and
> expression as well?
>
> Chris
>


--------------020101020406000100050005
Content-Type: text/plain; charset=ISO-8859-1;
 name="0001-mdep.c-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mdep.c-test.patch"

From aff7f53ce89d24512c0ba2f66b981718538ae1c8 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <eiselekd@gmail.de>
Date: Sat, 12 May 2012 18:43:16 +0200
Subject: [PATCH] mdep.c test

---
 Makefile      |    5 +-
 a.h           |    6 ++
 a2.h          |    2 +
 lib.c         |   19 +++--
 mdep.c        |  248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pre-process.c |    3 +-
 test-macro.c  |   10 +-
 test-mdep.c   |   62 ++++++++++++++
 token.h       |    8 ++-
 tokenize.c    |    8 +-
 10 files changed, 351 insertions(+), 20 deletions(-)
 create mode 100644 a.h
 create mode 100644 a2.h
 create mode 100644 mdep.c
 create mode 100644 test-mdep.c

diff --git a/Makefile b/Makefile
index 4abcbdd..b688054 100644
--- a/Makefile
+++ b/Makefile
@@ -44,7 +44,7 @@ PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
 	 test-linearize example test-unssa test-dissect ctags \
-	 test-macro
+	 test-mdep test-macro 
 
 INST_PROGRAMS=sparse cgcc
 INST_MAN1=sparse.1 cgcc.1
@@ -96,7 +96,8 @@ LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
+	  mdep.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
diff --git a/a.h b/a.h
new file mode 100644
index 0000000..63da9e8
--- /dev/null
+++ b/a.h
@@ -0,0 +1,6 @@
+//#include <stdio.h>
+#define D0(d0a0,d0a1) 1 D1(d0a0) 2 D2(d0a1) 3
+#define D1(d1a0) 4 d1a0 5
+#define D2(d2a0)
+#define D3(d3a0) 8 d3a0 9
+1 2  D0(D3(10),11) 3 4 
diff --git a/a2.h b/a2.h
new file mode 100644
index 0000000..098fbc2
--- /dev/null
+++ b/a2.h
@@ -0,0 +1,2 @@
+#define A(a,b) b 3 
+A(1,2)
diff --git a/lib.c b/lib.c
index 1876fc9..51879d9 100644
--- a/lib.c
+++ b/lib.c
@@ -577,6 +577,7 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 	return next;
 }
 
+int fnobuildin = 0;
 static char **handle_switch_f(char *arg, char **next)
 {
 	arg++;
@@ -588,6 +589,9 @@ static char **handle_switch_f(char *arg, char **next)
 
 	if (!strncmp(arg, "no-", 3)) {
 		arg += 3;
+		if (!strncmp(arg, "buildin", 7)) {
+			fnobuildin = 1;
+		}
 	}
 	/* handle switch here.. */
 	return next;
@@ -875,7 +879,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
 	token = preprocess(token);
 
 	if (preprocess_only) {
-		show_tokenstream(token);
+		show_tokenstream(token, 0);
 		putchar('\n');
 		return NULL;
 	}
@@ -963,12 +967,13 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		// Initialize type system
 		init_ctype();
 
-		create_builtin_stream();
-		add_pre_buffer("#define __CHECKER__ 1\n");
-		if (!preprocess_only)
-			declare_builtin_functions();
-
-		list = sparse_initial();
+		if (!fnobuildin) {
+			create_builtin_stream();
+			add_pre_buffer("#define __CHECKER__ 1\n");
+			if (!preprocess_only)
+				declare_builtin_functions();
+			list = sparse_initial();
+		}
 
 		/*
 		 * Protect the initial token allocations, since
diff --git a/mdep.c b/mdep.c
new file mode 100644
index 0000000..6af8467
--- /dev/null
+++ b/mdep.c
@@ -0,0 +1,248 @@
+/*
+ * Copyright (C) 2012 Konrad Eisele <eiselekd@gmail.com>
+ * BSD-License
+ * Redistribution and use in source and binary forms are permitted
+ * provided that the above copyright notice and this paragraph are
+ * duplicated in all such forms and that any documentation,
+ * advertising materials, and other materials related to such
+ * distribution and use acknowledge that the software was developed
+ * by the <organization>.  The name of the
+ * University may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#include "token.h"
+#include "allocate.h"
+#include "compat.h"
+#include "parse.h"
+#include "symbol.h"
+#include "token.h"
+#include "lib.h"
+
+static void expand_macro(struct token *macro, struct symbol *sym, 
+                         struct token *parent, struct token **replace, 
+                         struct token **replace_tail, struct token *last);
+static void expand_arg(struct token *macro, struct symbol *sym, int arg,
+		       struct token *orig, struct token *expanded);
+struct pp;
+struct pp_e;
+
+struct preprocess_hook pp = {
+    .expand_macro = expand_macro,
+    .expand_arg = expand_arg
+};
+
+unsigned int pps = 0;
+
+void mdep_init(void) {
+    preprocess_hook = &pp;
+    pps = init_stream("<pp>", -1, 0);
+}
+
+enum tags {
+    ATTR_TOK = 1,
+    ATTR_TOKP = 2,
+};
+
+struct hash_v {
+    struct hash_v *n;
+    long key;
+    enum tags tag;
+    void *v;
+};
+
+__DECLARE_ALLOCATOR(struct hash_v, hash_v);
+__ALLOCATOR(struct hash_v, "hash value", hash_v);
+
+#define HASH_LEN (1024*4)
+struct hash {
+    struct hash_v *f;
+} h[HASH_LEN];
+
+static int hash_func(long key, enum tags tag) {
+    unsigned int k = ((unsigned int)key) >> 4;
+    return ((k) ^ (k >> 16) ^ (k >> 24) ^ tag) & (HASH_LEN-1);
+}
+
+void **lookup_attr(long key, enum tags tag, int create) {
+    int i = hash_func(key, tag);
+    struct hash *hp = &h[i];
+    struct hash_v *p;
+    struct hash_v **c = &hp->f;
+    while((p = *c)) {
+        if ((p ->tag == tag)
+            && (p ->key == key)) {
+            return &p->v;
+        }
+        c = &p->n;
+    }
+    if (create) {
+        p = __alloc_hash_v(0);
+        p->key = key;
+        p->tag = tag;
+        p->v = 0;
+        *c = p;
+        return &p->v;
+    }
+    return 0;
+}
+
+enum pp_typ {
+    MARG = 1,
+    MBODY,
+};
+
+struct pp {
+    enum pp_typ t;
+    union {
+        unsigned int argi;
+    };
+    struct pp_e *f;
+    struct symbol *sym;
+    struct token *tok;
+    struct token *s, *d;
+};
+
+struct pp_e {
+    struct pp_e *n;
+    struct pp *p;
+    struct position from;
+    int idx;
+};
+
+__DECLARE_ALLOCATOR(struct pp, pp_v);
+__ALLOCATOR(struct pp, "pp trace", pp_v);
+__DECLARE_ALLOCATOR(struct pp_e, pp_e_v);
+__ALLOCATOR(struct pp_e, "pp trace element", pp_e_v);
+int n_tokid = 1;
+
+void pp_dope_list(struct pp *p, struct token **d, int dope, struct token *list, struct token *end, int prt)
+{
+    struct pp_e **e = &p->f;
+    struct token *n;
+    int idx = 0;
+    while ((!eof_token(list)) && list != end ) {
+        if (dope) {
+            void **v;
+            int id = n_tokid++;
+            struct pp_e *n = __alloc_pp_e_v(0);
+            n->from = list->pos;
+            n->idx = idx;
+            n->n = 0;
+            n->p = p;
+            *e = n;
+            v = lookup_attr(id, ATTR_TOK, 1);
+            *v = n;
+            list->pos.line = id;
+            list->pos.stream = pps;
+            e = &n->n;
+        }
+        n = __alloc_token(0);
+        *n = *list;
+        /*printf(" %s\n", show_token(list));*/
+        n->next = &eof_token_entry;
+        *d = n;
+        d = &n->next;
+        list = list->next;
+        idx++;
+        
+	
+    }
+}
+
+struct pp *new_pp(struct token *m, int t) {
+	struct pp *n = __alloc_pp_v(0);
+	n->t = t;
+	n->f = 0;
+	return n;
+}
+
+static void expand_macro(struct token *macro, struct symbol *sym, struct token *parent,
+			 struct token **replace, struct token **replace_tail, struct token *last)
+{
+    struct pp *p = new_pp(macro, MBODY);
+    p->sym = sym;
+    p->tok = macro;
+    pp_dope_list(p, &p->s, 0, sym->expansion, 0, 0);
+    pp_dope_list(p, &p->d, 1, *replace, last, 0);
+}
+
+static void expand_arg(struct token *macro, struct symbol *sym, int arg,
+		       struct token *orig, struct token *expanded)
+{
+    struct pp *p = new_pp(macro, MARG);
+    p->argi = arg;
+    p->sym = sym;
+    p->tok = macro;
+    pp_dope_list(p, &p->s, 0, orig, 0, 0);
+    pp_dope_list(p, &p->d, 1, expanded, 0, 0);
+}
+
+void mdep_show_tokenstream(struct token *token, struct token *end, int idx)
+{
+    int i = 0;
+    while (token != end && !eof_token(token)) {
+        int prec = 1;
+        struct token *next = token->next;
+        const char *separator = "";
+        if (next->pos.whitespace)
+            separator = " ";
+        if (next->pos.newline) {
+            separator = "\n\t\t\t\t\t";
+            prec = next->pos.pos;
+            if (prec > 4)
+                prec = 4;
+        }
+        if (i == idx) 
+            fprintf(stderr,"@{%s}%.*s", show_token(token), prec, separator);
+        else
+            fprintf(stderr,"%s%.*s", show_token(token), prec, separator);
+        token = next;
+        i++;
+    }
+}
+
+void mdep_trace (struct token *tok, char *pre)
+{
+    void **v; int id; struct position pos = tok->pos;
+    struct pp_e *e; struct pp *p;
+    pre = pre ? pre : "";
+    if(!tok || eof_token (tok)) 
+        return;
+    while(1) {
+        if (pos.stream != pps) {
+            char *name = stream_name(pos.stream);
+            fprintf(stderr, "%s%s:%d:%d\n", pre,
+                    name, pos.line, pos.pos);
+            break;
+        } 
+        id = pos.line;
+        if (!(v = lookup_attr(id, ATTR_TOK, 0))) {
+            break;
+        }
+        e = (struct pp_e *)*v;
+        p = e->p;
+        fprintf(stderr, "%s",pre); 
+        if (p->t == MARG) {
+            fprintf(stderr,"arg%d in %s :", p->argi, show_token(p->tok));
+        } else {
+            fprintf(stderr,"body in %s :", show_token(p->tok));
+        }
+        mdep_show_tokenstream(p->d, 0,e->idx); fprintf (stderr,"\n");
+        pos = e->from;
+    }
+}
+
+/*
+Local Variables:
+c-basic-offset:4
+indent-tabs-mode:nil
+End:
+*/
diff --git a/pre-process.c b/pre-process.c
index fb3430a..4eee864 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -385,6 +385,7 @@ static void expand_arguments(int count, struct arg *args)
 		struct token *arg = args[i].arg;
 		if (!arg)
 			arg = &eof_token_entry;
+		args[i].expanded = &eof_token_entry;
 		if (args[i].n_str)
 			args[i].str = stringify(arg);
 		if (args[i].n_normal) {
@@ -661,7 +662,7 @@ static int expand(struct token **list, struct symbol *sym)
 	last = token->next;
 	tail = substitute(list, sym->expansion, args);
 	if (preprocess_hook && preprocess_hook->expand_macro)
-		preprocess_hook->expand_macro(token, sym, parent, list, tail);
+		preprocess_hook->expand_macro(token, sym, parent, list, tail, last);
 	*tail = last;
 
 	return 0;
diff --git a/test-macro.c b/test-macro.c
index b30ee50..3115bef 100644
--- a/test-macro.c
+++ b/test-macro.c
@@ -22,9 +22,9 @@
 static void expand_arg(struct token *macro, struct symbol *sym, int i, struct token *orig, struct token *expanded)
 {
 	printf("arg%d in %s :", i, show_token(macro));
-	show_tokenstream(orig);
+	show_tokenstream(orig, 0);
 	printf(" -> ");
-	show_tokenstream(expanded);
+	show_tokenstream(expanded, 0);
 	printf("\n");
 	
 }
@@ -35,7 +35,7 @@ static void expand_macro(struct token *macro, struct symbol *sym, struct token *
 	printf("macro %s inside", show_token(macro));
 	printf(" %s\n", show_token(parent));
 	printf("expand result: ");
-	show_tokenstream(*replace);
+	show_tokenstream(*replace, 0);
 	printf("\n");
 }
 
@@ -55,11 +55,11 @@ void test_macro(char *filename)
 		die("No such file: %s", filename);
 
 	token = tokenize(filename, fd, NULL, includepath);
-	show_tokenstream(token);
+	show_tokenstream(token, 0);
 	printf("\n");
 	token = preprocess(token);
 	printf("After preprocessing\n");
-	show_tokenstream(token);
+	show_tokenstream(token, 0);
 }
 
 int main(int argc, char **argv)
diff --git a/test-mdep.c b/test-mdep.c
new file mode 100644
index 0000000..eca0357
--- /dev/null
+++ b/test-mdep.c
@@ -0,0 +1,62 @@
+/*
+ * Parse and linearize the tree for testing.
+ *
+ * Copyright (C) 2012 Christophre Li
+ *
+ */
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+
+void test_mdep(char *filename)
+{
+    struct token *token;
+    int fd; int idx = 0;
+    fd = open(filename, O_RDONLY);
+    if (fd < 0)
+        die("No such file: %s", filename);
+	
+    token = tokenize(filename, fd, NULL, includepath);
+    token = preprocess(token);
+    printf("Dump token stream:\n");
+    
+    while (!eof_token(token)) {
+        struct token *next = token->next;
+        printf("%04d: %s\n", idx, show_token(token));
+        mdep_trace (token, "     ");
+        token = next; idx++;
+    }
+    
+}
+
+int main(int argc, char **argv)
+{
+    struct string_list *filelist = NULL;
+    char *file;
+
+    mdep_init();
+	
+    sparse_initialize(argc, argv, &filelist);
+    FOR_EACH_PTR_NOTAG(filelist, file) {
+        test_mdep(file);
+    } END_FOR_EACH_PTR_NOTAG(file);
+    return 0;
+}
+
+/*
+Local Variables:
+c-basic-offset:4
+indent-tabs-mode:nil
+End:
+*/
diff --git a/token.h b/token.h
index 985d1f5..8ddccd5 100644
--- a/token.h
+++ b/token.h
@@ -173,7 +173,7 @@ struct token {
 
 struct preprocess_hook {
 	void (*expand_macro)(struct token *macro, struct symbol *sym, struct token *parent,
-			     struct token **replace, struct token **replace_tail);
+			     struct token **replace, struct token **replace_tail, struct token *last);
 	void (*expand_arg)(struct token *macro, struct symbol *sym, int arg,
 			   struct token *orig, struct token *expanded);
 };
@@ -206,7 +206,7 @@ extern const char *show_special(int);
 extern const char *show_ident(const struct ident *);
 extern const char *show_string(const struct string *string);
 extern const char *show_token(const struct token *);
-extern void show_tokenstream(struct token *token);
+extern void show_tokenstream(struct token *token, struct token *end);
 extern struct token * tokenize(const char *, int, struct token *, const char **next_path);
 extern struct token * tokenize_buffer(void *, unsigned long, struct token **);
 
@@ -223,4 +223,8 @@ static inline int match_ident(struct token *token, struct ident *id)
 	return token->pos.type == TOKEN_IDENT && token->ident == id;
 }
 
+/* mdep.c */
+extern void mdep_init (void);
+extern void mdep_trace (struct token *tok, char *pre);
+
 #endif
diff --git a/tokenize.c b/tokenize.c
index b626f3f..6d0978f 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -127,6 +127,8 @@ const char *show_token(const struct token *token)
 
 	if (!token)
 		return "<no token>";
+	if (token == &eof_token_entry)
+		return "<eof>";
 	switch (token_type(token)) {
 	case TOKEN_ERROR:
 		return "syntax error";
@@ -180,9 +182,9 @@ const char *show_token(const struct token *token)
 	}
 }
 
-void show_tokenstream(struct token *token)
+void show_tokenstream(struct token *token, struct token *end)
 {
-	while (!eof_token(token)) {
+	while (token != end && !eof_token(token)) {
 		int prec = 1;
 		struct token *next = token->next;
 		const char *separator = "";
@@ -194,7 +196,7 @@ void show_tokenstream(struct token *token)
 			if (prec > 4)
 				prec = 4;
 		}
-		printf("%s%.*s", show_token(token), prec, separator);
+		fprintf(stderr,"%s%.*s", show_token(token), prec, separator);
 		token = next;
 	}
 }
-- 
1.7.4.4


--------------020101020406000100050005--
