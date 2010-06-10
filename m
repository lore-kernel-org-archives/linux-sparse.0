From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Thu, 10 Jun 2010 12:18:07 -0700
Message-ID: <AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55158 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab0FJTmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Jun 2010 15:42:51 -0400
Received: by gye5 with SMTP id 5so237747gye.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 Jun 2010 12:42:50 -0700 (PDT)
In-Reply-To: <1276158810-21313-1-git-send-email-jslaby@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Jirl,

Thank you for the patch. Over all looks good.

Can you add a validations test case for me? It would be great to see
sparse fail on the test case then your patch makes it work.

Some minor nitpick follows. If you are busy, just give me the test case=
,
I can do the rest of the change for you,


On Thu, Jun 10, 2010 at 1:33 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> As of gcc 4.5, asm goto("jmp %l[label]" : OUT : IN : CLOB : LABELS) i=
s
> supported. Add this support to the parser so that it won't choke on
> the newest Linux kernel when compiling with gcc 4.5.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> =A0evaluate.c | =A0 =A08 ++++++++
> =A0parse.c =A0 =A0| =A0 23 +++++++++++++++++++++++
> =A0parse.h =A0 =A0| =A0 =A01 +
> =A03 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/evaluate.c b/evaluate.c
> index 28bfd7c..5bb26df 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3149,6 +3149,7 @@ static void verify_input_constraint(struct expr=
ession *expr, const char *constra
> =A0static void evaluate_asm_statement(struct statement *stmt)
> =A0{
> =A0 =A0 =A0 =A0struct expression *expr;
> + =A0 =A0 =A0 struct symbol *sym;
> =A0 =A0 =A0 =A0int state;
>
> =A0 =A0 =A0 =A0expr =3D stmt->asm_string;
> @@ -3225,6 +3226,13 @@ static void evaluate_asm_statement(struct stat=
ement *stmt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0expression_error(expr, "asm clobber is=
 not a string");
> =A0 =A0 =A0 =A0} END_FOR_EACH_PTR(expr);
> +
> + =A0 =A0 =A0 FOR_EACH_PTR(stmt->asm_labels, sym) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sym || sym->type !=3D SYM_LABEL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sparse_error(stmt->pos,=
 "bad asm label");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } END_FOR_EACH_PTR(sym);
> =A0}
>
> =A0static void evaluate_case_statement(struct statement *stmt)
> diff --git a/parse.c b/parse.c
> index f81b19f..e292570 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1889,12 +1889,33 @@ static struct token *parse_asm_clobbers(struc=
t token *token, struct statement *s
> =A0 =A0 =A0 =A0return token;
> =A0}
>
> +static struct token *parse_asm_labels(struct token *token, struct st=
atement *stmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct symbol_list **la=
bels)
> +{
> + =A0 =A0 =A0 struct symbol *label;

What is the stmt argument doing here?

> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D token->next; /* skip ':' and =
',' */

I think it would be better to enter parse_asm_labels with ':' already
skipped. You can modify the caller do:
parse_asm_lablels(token->next).

It is tempting to make the function name as parse_label_list() because
without ':', there is nothing specific about asm any more. It is your
call.

The while loop can write as follows, with fewer break outs
and read better for me.

while (token_type(token) =3D=3D TOKEN_IDENT) {
          struct symbol *label =3D label_symbol(token);
          add_symbol(lables, label);
          token =3D token->next;
          if (!match_op(token, ',')
                      break;
          token =3D token->next;
}



> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (token_type(token) !=3D TOKEN_IDENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return token;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D label_symbol(token);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_symbol(labels, label);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D token->next;
> + =A0 =A0 =A0 } while (match_op(token, ','));
> + =A0 =A0 =A0 return token;
> +}
> +
> =A0static struct token *parse_asm_statement(struct token *token, stru=
ct statement *stmt)
> =A0{
> + =A0 =A0 =A0 int is_goto =3D 0;
> +
> =A0 =A0 =A0 =A0token =3D token->next;
> =A0 =A0 =A0 =A0stmt->type =3D STMT_ASM;
> =A0 =A0 =A0 =A0if (match_idents(token, &__volatile___ident, &__volati=
le_ident, &volatile_ident, NULL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D token->next;
> + =A0 =A0 =A0 } else if (match_idents(token, &goto_ident, NULL)) {

match_idents is over kill here. You just need to do:
else if (token->ident =3D=3D &goto_ident) {


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_goto =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D token->next;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0token =3D expect(token, '(', "after asm");
> =A0 =A0 =A0 =A0token =3D parse_expression(token, &stmt->asm_string);
> @@ -1904,6 +1925,8 @@ static struct token *parse_asm_statement(struct=
 token *token, struct statement *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D parse_asm_operands(token, st=
mt, &stmt->asm_inputs);
> =A0 =A0 =A0 =A0if (match_op(token, ':'))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D parse_asm_clobbers(token, st=
mt, &stmt->asm_clobbers);
> + =A0 =A0 =A0 if (is_goto && match_op(token, ':'))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D parse_asm_labels(token, stmt,=
 &stmt->asm_labels);

parse_asm_labels(token->next ....) to match previous change.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
