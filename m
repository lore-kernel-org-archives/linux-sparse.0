From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/3] struct_union_enum_specifier: set MOD_TOPLEVEL if
 toplevel(sym->scope)
Date: Tue, 18 Feb 2020 11:38:38 +0100
Message-ID: <20200218103837.GA3466@redhat.com>
References: <20200214113320.GA31578@redhat.com>
 <20200217214610.uxbnfh5zooqve4yc@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgBRKio (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Feb 2020 05:38:44 -0500
In-Reply-To: <20200217214610.uxbnfh5zooqve4yc@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 02/17, Luc Van Oostenryck wrote:
>
> On Fri, Feb 14, 2020 at 12:33:20PM +0100, Oleg Nesterov wrote:
> > With this change dissect can know the scope of SYM_STRUCT/UNION/ENUM,
> > see the next patch.
> >
> > Note that MOD_TOPLEVEL can be set even if struct/union/enum type is
> > private and bind_symbol() is not called.
>
> I don't like that very much. For example: why this is needed for
> struct/union/enum and not other types?

Do you mean builtin types like int_ctype? OK, I agree, this is slightly
inconsistent.

> Should it be possible to use the function toplevel() or add and
> helper for it in scope.c?

Well, toplevel() won't work if SYM_STRUCT/etc is anonymous, in this
case bind_symbol() is not called and thus sym->scope = NULL.

Consider

	struct { int m; } x;

	void func(void)
	{
		struct { int m; } x;

	}

we want to report the 2nd struct definition as "local"

   1:8                    def   s :x
   1:14                   def   m :x.m                             int
   1:19                   def   v x                                struct :x
   3:6                    def   f func                             void ( ... )
   5:16  func             def . s :x
   5:22  func             def . m :x.m                             int
   5:27  func             def . v x                                struct :x

so that this spam can be filtered out, but base->scope is NULL in both
cases.

> > IIUC nobody else looks at SYM_STRUCT->ctype.modifiers, "make check"
> > doesn't show any difference.
>
> Yes, it's true and it shouldn't make any difference but still I
> would prefer to not mix symbols and types more than they already are.

OK, will you agree with one-liner below? This should make toplevel() work.

Oleg.

--- a/parse.c
+++ b/parse.c
@@ -772,6 +772,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	}
 
 	sym = alloc_symbol(token->pos, type);
+	sym->scope = block_scope;
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
