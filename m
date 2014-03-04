From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] Support GCC's transparent unions
Date: Tue, 4 Mar 2014 17:52:52 +0000
Message-ID: <20140304175252.GE18371@serenity.lan>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
 <303d3e76a8db47a65f2015289cfd5259611723bf.1393674078.git.john@keeping.me.uk>
 <CANeU7Q=ekL+ASkz-v9K14cP8GJox=O7f4C_YRpS0SmTBoy_02w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from jackal.aluminati.org ([72.9.247.210]:39708 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaCDRxD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Mar 2014 12:53:03 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7Q=ekL+ASkz-v9K14cP8GJox=O7f4C_YRpS0SmTBoy_02w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 04, 2014 at 09:21:50AM -0800, Christopher Li wrote:
> On Sat, Mar 1, 2014 at 3:41 AM, John Keeping <john@keeping.me.uk> wrote:
> > This stops warnings in code using socket operations with a modern glibc,
> > which otherwise result in warnings of the form:
> >
> >         warning: incorrect type in argument 2 (invalid types)
> >            expected union __CONST_SOCKADDR_ARG [usertype] __addr
> >            got struct sockaddr *<noident>
> >
> > Since transparent unions are only applicable to function arguments, we
> > create a new function to check that the types are compatible
> > specifically in this context.
> 
> Can you please keep the option to warning about the transparent union?
> You can change the default to off. While you are there, please make the second
> patch base on the chrisl sparse repository.

Will do.

> > +static int compatible_argument_type(struct expression *expr, struct symbol *target,
> > +       struct expression **rp, const char *where)
> > +{
> > +       const char *typediff;
> > +       struct symbol *source = degenerate(*rp);
> > +       struct symbol *t;
> > +       classify_type(target, &t);
> > +
> > +       if (t->type == SYM_UNION && t->transparent_union) {
> > +               struct symbol *member;
> > +               FOR_EACH_PTR(t->symbol_list, member) {
> > +                       if (check_assignment_types(member, rp, &typediff))
> > +                               return 1;
> > +               } END_FOR_EACH_PTR(member);
> > +       }
> > +
> > +       if (check_assignment_types(target, rp, &typediff))
> > +               return 1;
> > +
> > +       warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
> > +       info(expr->pos, "   expected %s", show_typename(target));
> > +       info(expr->pos, "   got %s", show_typename(source));
> > +       *rp = cast_to(*rp, target);
> > +       return 0;
> > +}
> 
> I found this compatible_argument_type() hard to read. There are code
> copy/paste from the function compatible_assignment_types().
> 
> I think a better way  is:
> static int compatible_argument_type(...)
> {
>      struct symbol *t;
>      classify_type(target, &t);
> 
>      if (t->type == SYM_UNION && t->transparent_union)
>             return compatible_assignment_transparent_union(...);
>      return compatible_assignment_types(...);
> }
> 
> Then you just need to complete the function
> compatible_assignment_transparent_union().
> Call compatible_assignment_types() if needed.

I'm not sure I understand what you mean here.  If I extract
compatible_assignment_transparent_union() then it is essentially the
same as compatible_argument_type() but without the check for
t->transparent_union.

Looking again, I can see that my implementation above is unnecessarily
complicated because the warning() block is identical to that in
compatible_assignment_types() and there's no way for typediff to escape
from the transparent_union look, so the last 8 lines can be replaced by:

    return compatible_assignment_types(target, rp, &typediff);

That also allows us to get rid of 'source', so we end up with:

static int compatible_argument_type(struct expression *expr, struct symbol *target,
       struct expression **rp, const char *where)
{
	struct symbol *t;
	classify_type(target, &t);

	if (t->type == SYM_UNION && t->transparent_union) {
		const char *typediff;
		struct symbol *member;
		FOR_EACH_PTR(t->symbol_list, member) {
			if (check_assignment_types(member, rp, &typediff))
				return 1;
		} END_FOR_EACH_PTR(member);
	}

	return compatible_assignment_types(expr, target, rp, where);
}


I'm not sure moving the contents of the if block into a separate
function improves things much at that point.  What do you think?
