From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] pre-process: replace use of vla's with heap allocation
Date: Thu, 20 Jul 2017 08:02:33 -0400
Message-ID: <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com>
References: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35381 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934876AbdGTMCe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 08:02:34 -0400
Received: by mail-pg0-f43.google.com with SMTP id v190so13980398pgv.2
        for <linux-sparse@vger.kernel.org>; Thu, 20 Jul 2017 05:02:34 -0700 (PDT)
In-Reply-To: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 4:13 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> The 'selfcheck' make target issues warnings about using vla's in the
> pre-processor code, like so:
>
>        CHECK    pre-process.c
>   pre-process.c:712:25: warning: Variable length array is used.
>   pre-process.c:2019:28: warning: Variable length array is used.
>
> A Makefile change to pass '-Wno-vla' to sparse when processing this
> source file (or all source files) may be a better solution than the
> one given here.
>
> Replace the use of vla's with heap allocation. This has performance
> implications (although it may me safer), due to the dynamic memory
> allocation and the zero initialisation of the memory (using calloc).
> I have not done any timing measurements to see if this is a problem
> in practice.

I purpose the following patch. Make the expand using stack for small
argument numbers. That should not have much performance impact
at all because long macro arguments are rare.

Incremental patch follows. If you think that is fine, I will apply the
combined patch as yours.

> +       if (nargs > 0)
> +               args = calloc(nargs, sizeof(*args));

Need to check alloc failed.

> +
>         if (sym->arglist) {
>                 if (!match_op(scan_next(&token->next), '('))
>                         return 1;

Need to free alloc memory.


> +       if (nargs > 0)
> +               args = calloc(nargs, sizeof(*args));

Same here need to check alloc failed.

Chris

Purposed incremental fix up follows:

--- sparse.chrisl.orig/pre-process.c
+++ sparse.chrisl/pre-process.c
@@ -709,21 +709,30 @@ static int expand(struct token **list, s
  struct ident *expanding = token->ident;
  struct token **tail;
  int nargs = sym->arglist ? sym->arglist->count.normal : 0;
- struct arg *args = NULL;
+#define ARG_LIMIT 8
+ struct arg arg_array[ARG_LIMIT], *args = arg_array;
+ int err = 0;

  if (expanding->tainted) {
  token->pos.noexpand = 1;
  return 1;
  }

- if (nargs > 0)
+ if (nargs >= ARG_LIMIT) {
  args = calloc(nargs, sizeof(*args));
+ if (!args)
+ die("calloc(%d, %lu) failed", nargs, sizeof(*args));
+ }

  if (sym->arglist) {
- if (!match_op(scan_next(&token->next), '('))
- return 1;
- if (!collect_arguments(token->next, sym->arglist, args, token))
- return 1;
+ if (!match_op(scan_next(&token->next), '(')) {
+ err = 1;
+ goto exit;
+ }
+ if (!collect_arguments(token->next, sym->arglist, args, token)) {
+ err = 1;
+ goto exit;
+ }
  expand_arguments(nargs, args);
  }

@@ -741,9 +750,11 @@ static int expand(struct token **list, s
  (*list)->pos.whitespace = token->pos.whitespace;
  *tail = last;

- free(args);
+exit:
+ if (nargs >= ARG_LIMIT)
+ free(args);

- return 0;
+ return err;
 }

 static const char *token_name_sequence(struct token *token, int
endop, struct token *start)
@@ -2024,8 +2035,11 @@ static void dump_macro(struct symbol *sy
  struct token **args = NULL;
  struct token *token;

- if (nargs > 0)
+ if (nargs > 0) {
  args = calloc(nargs, sizeof(*args));
+ if (!args)
+ die("calloc %ld", nargs * sizeof(*args));
+ }

  printf("#define %s", show_ident(sym->ident));
  token = sym->arglist;
