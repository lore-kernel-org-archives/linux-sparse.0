From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v6] sparse: add support for _Static_assert
Date: Tue, 9 May 2017 13:42:39 -0400 (EDT)
Message-ID: <508829304.6362470.1494351759113.JavaMail.zimbra@redhat.com>
References: <20170508211543.20681-1-lrichard@redhat.com> <CANeU7Q=oVwcFtB-RhG0+iFoHsF2BR+_wMZ4MP4x+ZmKDfvatew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbdEIRmj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 13:42:39 -0400
In-Reply-To: <CANeU7Q=oVwcFtB-RhG0+iFoHsF2BR+_wMZ4MP4x+ZmKDfvatew@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> From: "Christopher Li" <sparse@chrisli.org>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> Sent: Tuesday, 9 May, 2017 11:53:43 AM
> Subject: Re: [PATCH v6] sparse: add support for _Static_assert
> 
> Hi Lance,
> 
> thanks for the patch. Looks very good.
> Have some very minor comment below:
> 
> 
> On Mon, May 8, 2017 at 2:15 PM, Lance Richardson <lrichard@redhat.com> wrote:
> > @@ -1945,13 +1953,17 @@ static struct token *declaration_list(struct token
> > *token, struct symbol_list **
> >  static struct token *struct_declaration_list(struct token *token, struct
> >  symbol_list **list)
> >  {
> >         while (!match_op(token, '}')) {
> > -               if (!match_op(token, ';'))
> > -                       token = declaration_list(token, list);
> > -               if (!match_op(token, ';')) {
> > -                       sparse_error(token->pos, "expected ; at end of
> > declaration");
> > -                       break;
> > +               if (match_ident(token, &_Static_assert_ident))
> > +                       token = parse_static_assert(token, NULL);
> 
> I agree with Luc that his better with a "continue" then
> the following "else" section does not need to changed.
> 
> 
> > @@ -2093,6 +2105,37 @@ static struct token *parse_asm_declarator(struct
> > token *token, struct decl_state
> >         return token;
> >  }
> >
> > +static struct token *parse_static_assert(struct token *token, struct
> > symbol_list **unused)
> > +{
> > +       struct expression *cond = NULL, *message = NULL;
> > +       struct token *errtok;
> > +       int valid = 1;
> > +
> > +       token = expect(token->next, '(', "after _Static_assert");
> > +       errtok = token;
> > +       token = constant_expression(token, &cond);
> > +       if (!cond) {
> 
> I think errtok is not needed here. If there is an expression, the normal
> case. Then errtok will holding the start of the expression. errok->pos
> == cond->pos.
> Call it errtok is a bit miss leading.
> 
> If cond == NULL,  that means the expression is empty. Then we have
> errtok == token. Either way errtok is not very useful.
> 
> > +               sparse_error(errtok->pos, "Expected constant expression");
> 
> BTW, when the error happen here, "errtok" is actually the next token after
> the missing expression, normally the ','. So the error actually happen before
> that token.
> 

OK

> > +               valid = 0;
> > +       }
> > +       token = expect(token, ',', "after conditional expression in
> > _Static_assert");
> > +       errtok = token;
> > +       token = parse_expression(token, &message);
> > +       if (!message || message->type != EXPR_STRING) {
> > +               sparse_error(errtok->pos, "bad or missing string literal");
> > +               valid = 0;
> > +       }
> > +       token = expect(token, ')', "after diagnostic message in
> > _Static_assert");
> > +
> > +        token = expect(token, ';', "after _Static_assert()");
> 
> There is some white space mix with tab in this line.
> 
> > +
> > +       if (valid && !const_expression_value(cond) && cond->type ==
> > EXPR_VALUE)
> 
> I am tempted to get rid of the "valid" variable. BTW, the "cond->type
> == EXPR_VALUE"
> should take place *before* the "!const_expression_value(cond)", other
> wise it will try
> to get const expression for non value expression, due to the evaluate order.
> 
> Some thing like:
> 
>             if (cond && cond->type == EXPR_VALUE &&
> !const_expression_value(cond))

This doesn't work for some cases.  E.g. for an expression like
"sizeof(struct s) == 16", cond->type is EXPR_COMPARE before
const_expression_value(cond) is called and is only set to EXPR_VALUE after
the call has reduced the expression to a value. I was looking at this test
as a way to verify that const_expression_value() was successful.

I do think we can get rid of the "valid" variable though, as you suggest.

> 
> > +               sparse_error(cond->pos, "static assertion failed: %s",
> > +                            show_string(message->string));
> 
> Then there:
>            message ?  show_string(message->string) : "");
> 
> I think the assert failed without message string, we already report
> the error on empty string
> expression. Raising the assert here might be acceptable?
> 

I was taking the more conservative approach of not assuming anything
about the interpretation of the two expressions if the assertion is not
syntactically correct. This seems like a better way to go.

> Chris
> 

Thanks for the feedback, I will roll a new version shortly.

   Lance
