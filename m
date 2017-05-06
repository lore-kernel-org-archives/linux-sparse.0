From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Sun, 7 May 2017 01:11:29 +0200
Message-ID: <20170506231128.h65gxchj3dbaxfmp@desk.local>
References: <20170504160038.5328-1-lrichard@redhat.com>
 <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33914 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbdEFXLd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 May 2017 19:11:33 -0400
Received: by mail-wr0-f172.google.com with SMTP id l9so20131108wre.1
        for <linux-sparse@vger.kernel.org>; Sat, 06 May 2017 16:11:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, May 06, 2017 at 04:22:04PM -0400, Christopher Li wrote:
> I play with it a bit.
> 
> On Thu, May 4, 2017 at 12:00 PM, Lance Richardson <lrichard@redhat.com> wrote:
> > +static int match_static_assert(struct token *token)
> > +{
> > +       return token_type(token) == TOKEN_IDENT &&
> > +              token->ident == &_Static_assert_ident;
> > +}
> 
> I just find out there is already function match_ident() so use that
> instead will make it clear it is compare against "_Static_assert".
> Sorry I forget about this function earlier. I only find it when I play
> with the code today.

Yes, it's even better with match_ident().

> >
> >  struct statement *alloc_statement(struct position pos, int type)
> >  {
> > @@ -1864,13 +1877,17 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
> >  static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
> >  {
> >         while (!match_op(token, '}')) {
> > -               if (!match_op(token, ';'))
> > -                       token = declaration_list(token, list);
> > -               if (!match_op(token, ';')) {
> > -                       sparse_error(token->pos, "expected ; at end of declaration");
> > -                       break;
> > +               if (match_static_assert(token))
> > +                       token = parse_static_assert(token, NULL);
> > +               else {
> > +                       if (!match_op(token, ';'))
> > +                               token = declaration_list(token, list);
> > +                       if (!match_op(token, ';')) {
> > +                               sparse_error(token->pos, "expected ; at end of declaration");
> > +                               break;
> > +                       }
> > +                       token = token->next;
> 
> I reshape the code a bit to make it looks compact. Please see my
> attachment patch.

Yes, it's the same as I did.

> > +static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
> > +{
> > +       struct expression *expr1 = NULL, *expr2 = NULL;
> > +       int val;
> > +
> > +       token = expect(token->next, '(', "after _Static_assert");
> > +       token = constant_expression(token, &expr1);
> > +       token = expect(token, ',', "after first argument of _Static_assert");
> > +       token = parse_expression(token, &expr2);
> > +       token = expect(token, ')', "after second argument of _Static_assert");
> > +
> > +        token = expect(token, ';', "after _Static_assert()");
> > +
> > +       if (!expr1 || !expr2)
> > +               return token;
> 
> OK,  this parsing does not complain about the following input:
> _Static_assert(0, );
> _Static_assert(, "");

Ohoh, indeed.
 
> I fix it in my patch. While I am there, I rename the expr1 to "cond".

Good.
But I have two comments on your patch (I included it here below).

> @@ -2093,6 +2107,40 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
> +
> +static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
> +{
> +	struct expression *cond = NULL, *fail_string = NULL;
> +	int val;
> +
> +	token = expect(token->next, '(', "after _Static_assert");
> +	token = constant_expression(token, &cond);
> +	if (!cond)
> +		sparse_error(token->pos, "expect expression before '%s' token", show_token(token));

I would prefer to put this validation after the parsing
rather than in the middle but it's a detail.

> +	token = expect(token, ',', "after first argument of _Static_assert");
> +	token = parse_expression(token, &fail_string);
> +	if (!fail_string)
> +		sparse_error(token->pos, "expect expression before '%s' token", show_token(token));

ditto.

> +	token = expect(token, ')', "after second argument of _Static_assert");
> +
> +	expect(token, ';', "after _Static_assert()");
> +
> +	if (!cond || !fail_string)
> +		return token;

This test no become unneeded.
Well, I mean that it would be better to move the tests above here
in place of this one. 

> +
> +	val = const_expression_value(cond);
> +
> +	if (fail_string->type != EXPR_STRING) {
> +		sparse_error(fail_string->pos, "bad string literal");
> +		return token;
> +	}

Same, better to put all these validation together.

> +	if (cond->type == EXPR_VALUE && !val)
> +		sparse_error(cond->pos, "static assertion failed: %s",
> +				show_string(fail_string->string));
> +	return token;
> +}
> +

> 
> >  /* Make a statement out of an expression */
> >  static struct statement *make_statement(struct expression *expr)
> >  {
> > @@ -2389,11 +2436,14 @@ static struct token * statement_list(struct token *token, struct statement_list
> >                         }
> >                         stmt = alloc_statement(token->pos, STMT_DECLARATION);
> >                         token = external_declaration(token, &stmt->declaration);
> > +                       add_statement(list, stmt);
> > +               } else if (match_static_assert(token)) {
> > +                       token = parse_static_assert(token, NULL);
> 
> After take a closer look of the grimmer syntax. Static assert is
> actually a declaration rather than a statement. So I merge this
> two because external_declaration() can handle _Static_assert
> parsing any way.

Well, yes but it's a very strange 'declaration'. I had also
looked if both could be merged and concluded that they should
not for two reasons:
1) the grammar of a declaration and the static-assert has one
   difference in the way the final ';' is handled.
   It's included in the spec of static-assert while it's left
   out for declaration (but included in declaration-list)
   With your change here, sparse will complain twice when a
   trailing ';' is missing, and if you remove the "expect(';')"
   in parse_static_assert then:
    - you will have a warning 'Expected ; at the end of type declaration'
      for something that nobody will consider to be a declaration
      (well ok, nobody but the ones that read such details in the
      C grammar).
    - is there situations where a 'declaration' need not to be
      terminated by a ';' ?
2) I think that _Static_assert() should not be considered as a
   declaration but as a statement regarding -Wdeclaration-after-statement.
   Lance's version did this but yours doesn't anymore.
   Of course in the standard they can mix the two in the spec
   since it's OK for the standard to mix decls and statements.
   But that's not true anymore with -Wdeclaration-after-statement
   I certainly want to use the following code without a warning
   'mixing declarations and code' but I want to have this warning
   when a 'true' declaration is mixed with statements.

Maybe these two points can be handled by adding a few conditions
but will the result be clearer than Lance's version?

Also, that's just tow points I saw when seeing you have merged the
two, maybe there is others points that need consideration.

> Just need to pay attention it does not generate
> resulting symbol node.
> 
> I rename the patch as V6. V5 does not apply to master any more.
> 
> Luc, can you take a look the V6 patch as well?
>
> Thanks

Done :)

-- Luc
