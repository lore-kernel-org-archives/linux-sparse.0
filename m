From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Sun, 06 May 2012 01:38:16 +0200
Message-ID: <4FA5B9E8.7010208@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com> <4FA44E3D.6020504@gmail.com> <CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com> <4FA4EAD6.1040206@gmail.com> <CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com> <CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com> <CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com> <CANeU7QkJJx6A8zfZ
 Y9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030706060204040705080306"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41061 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab2EEXep (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 May 2012 19:34:45 -0400
Received: by lbbgm6 with SMTP id gm6so2764903lbb.19
        for <linux-sparse@vger.kernel.org>; Sat, 05 May 2012 16:34:44 -0700 (PDT)
In-Reply-To: <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030706060204040705080306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> I'll come up with a patch to implement this scheme when I have
>> time to and send it, it might take a while.
>
> Can you keep the change to the core sparse library (e.g. adding
> hook in parser and pre-processor) as a separate patch? You can
> send that part out for review earlier if other part of your dependency
> analyse is not ready yet.

I appended a diff for review. Is this kind of interface ok?
This is kind of not a patch to apply, rather I want to avoid to put
effort in it and you telling me later I am too intrusive...:). So
can you give a ok or comment...

Interface so far:
struct preprocess_hook {
	def      : called when #define is processed
	args_beg : called before argument expasnion
	args_end : called after argument expasnion
	body_beg : called before body expansion
	body_end : called after body expansion
	post     : called after preprocess
};
All of there I found are needed. There might be more to be added...

I also introduce a tokentype TOKEN_M_EMPTY so that I can track
empty expansion. To filter these out again I add the post hook.

-- Konrad








>
> Chris
>


--------------030706060204040705080306
Content-Type: text/plain; charset=ISO-8859-1;
 name="diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff.txt"

diff --git a/lib.c b/lib.c
index 396e9f1..554d6c4 100644
--- a/lib.c
+++ b/lib.c
@@ -974,7 +974,8 @@ struct symbol_list * __sparse(char *filename)
 	res = sparse_keep_tokens(filename);
 
 	/* Drop the tokens for this file after parsing */
-	clear_token_alloc();
+	if (!PPHOOKEN())
+		clear_token_alloc();
 
 	/* And return it */
 	return res;
diff --git a/pre-process.c b/pre-process.c
index 8a16f8b..99ee5a4 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -30,6 +30,8 @@
 
 static int false_nesting = 0;
 
+struct preprocess_hook *preprocess_hook = NULL;
+
 #define INCLUDEPATHS 300
 const char *includepath[INCLUDEPATHS+1] = {
 	"",
@@ -74,9 +76,10 @@ static const char **dirafter_includepath = includepath + 3;
 static struct token *alloc_token(struct position *pos)
 {
 	struct token *token = __alloc_token(0);
-
-	token->pos.stream = pos->stream;
-	token->pos.line = pos->line;
+	if (PPHOOKEN()) {
+		token->pos.stream = pos->stream;
+		token->pos.line = pos->line;
+	}
 	token->pos.pos = pos->pos;
 	token->pos.whitespace = 1;
 	return token;
@@ -106,7 +109,7 @@ static void replace_with_integer(struct token *token, unsigned int val)
 	token->number = buf;
 }
 
-static struct symbol *lookup_macro(struct ident *ident)
+struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
 	if (sym && sym->namespace != NS_MACRO)
@@ -231,28 +234,17 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		} else if (match_op(next, ',') && !nesting && !vararg) {
 			break;
 		}
-		next->pos.stream = pos->stream;
-		next->pos.line = pos->line;
-		next->pos.pos = pos->pos;
+		if (!PPHOOKEN()) {
+			next->pos.stream = pos->stream;
+			next->pos.line = pos->line;
+			next->pos.pos = pos->pos;
+		}
 		p = &next->next;
 	}
 	*p = &eof_token_entry;
 	return next;
 }
 
-/*
- * We store arglist as <counter> [arg1] <number of uses for arg1> ... eof
- */
-
-struct arg {
-	struct token *arg;
-	struct token *expanded;
-	struct token *str;
-	int n_normal;
-	int n_quoted;
-	int n_str;
-};
-
 static int collect_arguments(struct token *start, struct token *arglist, struct arg *args, struct token *what)
 {
 	int wanted = arglist->count.normal;
@@ -476,6 +468,8 @@ static struct token *dup_token(struct token *token, struct position *streampos,
 {
 	struct token *alloc = alloc_token(streampos);
 	token_type(alloc) = token_type(token);
+	alloc->pos.stream = pos->stream;
+	alloc->pos.line = pos->line;
 	alloc->pos.newline = pos->newline;
 	alloc->pos.whitespace = pos->whitespace;
 	alloc->number = token->number;
@@ -618,13 +612,21 @@ static int expand(struct token **list, struct symbol *sym)
 			return 1;
 		if (!collect_arguments(token->next, sym->arglist, args, token))
 			return 1;
+
+		PPHOOK (args_beg, token, nargs, args);
 		expand_arguments(nargs, args);
+		PPHOOK (args_end, token, nargs, args);
 	}
 
 	expanding->tainted = 1;
 
 	last = token->next;
+
+	PPHOOK (body_beg, token, sym->expansion);
+
 	tail = substitute(list, sym->expansion, args);
+	PPHOOK (body_end, token, list, tail);
+
 	*tail = last;
 
 	return 0;
@@ -893,6 +895,8 @@ static int token_list_different(struct token *list1, struct token *list2)
 			return 0;
 		if (!list1 || !list2)
 			return 1;
+		while(PPHOOKEN() && token_type(list1) == TOKEN_M_EMPTY) list1 = list1->next;
+		while(PPHOOKEN() && token_type(list2) == TOKEN_M_EMPTY) list2 = list2->next;
 		if (token_different(list1, list2))
 			return 1;
 		list1 = list1->next;
@@ -1140,6 +1144,8 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 
 	ret = 1;
 	sym = lookup_symbol(name, NS_MACRO | NS_UNDEF);
+	PPHOOK (def, left, &expansion);
+	
 	if (sym) {
 		int clean;
 
@@ -1835,6 +1841,7 @@ struct token * preprocess(struct token *token)
 	preprocessing = 1;
 	init_preprocessor();
 	do_preprocess(&token);
+	PPHOOK(post, &token);
 
 	// Drop all expressions from preprocessing, they're not used any more.
 	// This is not true when we have multiple files, though ;/
diff --git a/token.h b/token.h
index cd29233..0111d23 100644
--- a/token.h
+++ b/token.h
@@ -84,6 +84,7 @@ enum token_type {
 	TOKEN_IF,
 	TOKEN_SKIP_GROUPS,
 	TOKEN_ELSE,
+	TOKEN_M_EMPTY,
 };
 
 /* Combination tokens */
@@ -171,6 +172,32 @@ struct token {
 	};
 };
 
+/*
+ * We store arglist as <counter> [arg1] <number of uses for arg1> ... eof
+ */
+
+struct arg {
+	struct token *arg;
+	struct token *expanded;
+	struct token *str;
+	int n_normal;
+	int n_quoted;
+	int n_str;
+};
+
+struct preprocess_hook {
+	void (*def)(struct token *macro, struct token **ex);
+	void (*args_beg)(struct token *macro, int count, struct arg *a);
+	void (*args_end)(struct token *macro, int count, struct arg *a);
+	void (*body_beg)(struct token *macro, struct token *body);
+	void (*body_end)(struct token *macro, struct token **rep, struct token **reptail);
+	void (*post)(struct token **token);
+	
+	
+};
+#define PPHOOK(n, args... ) if (preprocess_hook && preprocess_hook->n) preprocess_hook->n( args );
+#define PPHOOKEN() (preprocess_hook != 0) 
+
 #define MAX_STRING 4095
 
 static inline struct token *containing_token(struct token **p)
@@ -188,7 +215,9 @@ static inline struct token *containing_token(struct token **p)
  */
 extern struct token eof_token_entry;
 #define eof_token(x) ((x) == &eof_token_entry)
+extern struct preprocess_hook *preprocess_hook;
 
+extern struct symbol *lookup_macro(struct ident *ident);
 extern int init_stream(const char *, int fd, const char **next_path);
 extern const char *stream_name(int stream);
 extern struct ident *hash_ident(struct ident *);

--------------030706060204040705080306--
