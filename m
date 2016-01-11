From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH] sparse: add support for static assert
Date: Sun, 10 Jan 2016 21:54:24 -0500 (EST)
Message-ID: <1249921583.11998072.1452480864238.JavaMail.zimbra@redhat.com>
References: <1452105317-5828-1-git-send-email-lrichard@redhat.com> <20160109135440.GA6833@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42177 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940AbcAKCy0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Jan 2016 21:54:26 -0500
In-Reply-To: <20160109135440.GA6833@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

----- Original Message -----
> On Wed, Jan 06, 2016 at 01:35:17PM -0500, Lance Richardson wrote:
> > This patch introduces support for _Static_assert() in global,
> > function, and struct/union declaration contexts (as currently supported
> > by gcc).
> > 
> > Tested via:
> >    - kernel build with C=1 CF=-D__CHECK_ENDIAN__
> >    - build/check large code base making heavy use of _Static_assert()
> >    - "make check" with added test case for static assert support
> 
> Nice, it was something that was indeed missing.
> 
> I have a few remarks, mostly nitpicking, here under.

Hi Luc, thanks for taking the time to review this.

> 
> 
> Luc
> 
> > @@ -437,6 +443,10 @@ static struct init_keyword {
> >  	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
> >  	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
> >  
> > +
> > +	/* Static assertion */
> > +	{ "_Static_assert", NS_TYPEDEF, .op = &static_assert_op },
> > +
> 
> It seems a bit strange to me to use NS_TYPEDEF, as this is unrelated types.
> OTOH, the other namespaces deosn't seems better suited,
> and yes C11 define this as sort of declaration, so ...

Agreed.

> 
> > @@ -2004,6 +2014,27 @@ static struct token *parse_asm_declarator(struct
> > token *token, struct decl_state
> >  	return token;
> >  }
> >  
> > +
> > +static struct token *static_assert_specifier(struct token *token, struct
> > decl_state *ctx)
> > +{
> > +	struct expression *expr = NULL;
> > +	int val;
> > +
> > +	token = constant_expression(token->next, &expr);
> > +	if (!expr)
> > +		sparse_error(token->pos, "Expected constant expression");
> > +	val = get_expression_value(expr);
> > +	token = expect(token, ',', "after first argument of _Static_assert");
> > +	token = parse_expression(token, &expr);
> > +	token = expect(token, ')', "after second argument of _Static_assert");
> > +
> > +	if (!val)
> > +		sparse_error(token->pos, "static assertion failed: %s",
> > +                             show_string(expr->string));
> 
> By using token->pos here, the error message will indicate that the problem is
> situated at the very end of the assertion; more exactly, at the ending ";".
> This is a little annoying I find.
> It would be better to use the some position as the expression
> (expr->pos, or the same as for "Expected constant expression").

Will fix in v2.

> 
> I find also a bit strange to have this sort of semantic check inside the
> parser.

This prompted me to look at the gcc implementation, it appears that gcc also
processes _Static_assert() during parsing.

>  
> > diff --git a/validation/static_assert.c b/validation/static_assert.c
> > new file mode 100644
> > index 0000000..baab346
> > --- /dev/null
> > +++ b/validation/static_assert.c
> > @@ -0,0 +1,20 @@
> > +_Static_assert(1, "global ok");
> > +
> > +struct foo {
> > +	_Static_assert(1, "struct ok");
> > +};
> > +
> > +void bar(void)
> > +{
> > +	_Static_assert(1, " func ok");
> > +}
> > +
> > +_Static_assert(0, "expected failure");
> > +/*
> > + * check-name: static assertion
> > + *
> > + * check-error-start
> > +static_assert.c:12:38: error: static assertion failed: "expected failure"
> > + * check-error-end
> > + */
> 
> It would be nice to add a few more test cases,
> I'm thinbking to things like:
> 	static int f;
> 	_Static_assert(f, "non-constant expression");
> 	static int *p;
> 	_Static_assert(p, "non-integer expression");
> 	_Static_assert(0.1, "float expression");
> 	
> 	_Static_assert(!0 == 1, "non-trivial expression");
> 	
> 	static int array[4];
> 	_Static_assert(sizeof(array), "sizeof expression");
> 	
> 	static const char non_literal_string[] = "non literal string";
> 	_Static_assert(0, non_literal_string);
> 

Will do.

> Also, what should happen with:
> 	_Static_assert(1 / 0, "invalid expression: should not show up?");
> (The C11 standard is not clear to me, GCC outputs an "invalid expression"
> message and ignore the assertion).

v2 will output something like "invalid constant integer expression".

> 
> Finally, the standard also allow to place the assertion
> inside a struct or union declaration; like:
> 	struct s {
> 		char c;
> 		_Static_assert(1, "inside struct");
> 	};
> which is working fine.
> And also, I think:
> 	struct s2 {
> 		char c;
> 		_Static_assert(sizeof(struct s) == 1, "own struct sizeof");
> 	};
> which doesn't.

The second case should work (unless you intended "sizeof(struct s2)"), the v2
implementation will be a little different to address this issue.

> 
> 
> Yours,
> Luc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks again for the feedback, I'll send v2 of the patch in the next few days.
