From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Support GCC's transparent unions
Date: Tue, 4 Mar 2014 16:58:27 -0800
Message-ID: <CANeU7Q=dc0-mn8nxsNQV5U8G0aryb_OLtq2BMUntEkvZwi8S1Q@mail.gmail.com>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
	<303d3e76a8db47a65f2015289cfd5259611723bf.1393674078.git.john@keeping.me.uk>
	<CANeU7Q=ekL+ASkz-v9K14cP8GJox=O7f4C_YRpS0SmTBoy_02w@mail.gmail.com>
	<20140304175252.GE18371@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:62581 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbaCEA62 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Mar 2014 19:58:28 -0500
Received: by mail-qa0-f50.google.com with SMTP id o15so336528qap.23
        for <linux-sparse@vger.kernel.org>; Tue, 04 Mar 2014 16:58:27 -0800 (PST)
In-Reply-To: <20140304175252.GE18371@serenity.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 4, 2014 at 9:52 AM, John Keeping <john@keeping.me.uk> wrote:
> Looking again, I can see that my implementation above is unnecessarily
> complicated because the warning() block is identical to that in
> compatible_assignment_types() and there's no way for typediff to escape
> from the transparent_union look, so the last 8 lines can be replaced by:
>
>     return compatible_assignment_types(target, rp, &typediff);
>
> That also allows us to get rid of 'source', so we end up with:
>
> static int compatible_argument_type(struct expression *expr, struct symbol *target,
>        struct expression **rp, const char *where)
> {
>         struct symbol *t;
>         classify_type(target, &t);
>
>         if (t->type == SYM_UNION && t->transparent_union) {
>                 const char *typediff;
>                 struct symbol *member;
>                 FOR_EACH_PTR(t->symbol_list, member) {
>                         if (check_assignment_types(member, rp, &typediff))
>                                 return 1;
>                 } END_FOR_EACH_PTR(member);
>         }
>
>         return compatible_assignment_types(expr, target, rp, where);
> }
>
>
> I'm not sure moving the contents of the if block into a separate
> function improves things much at that point.  What do you think?

That is better, if you submit code like that, I will not reject it.
The difference is relatively minor,  fall into the personal preference category.

Let me explain why I suggest that way.

The if statement for transparent union is a very rare and special case.
In other world, it is the cold and slow path.

People reading the compatible_argument_type() functions will most likely
have the normal assignment check in mind. It will go straight to the last
return statement. That is the hot and fast path.

And the implementation of transparent union aka the slow path is a lot
more complicate than the fast path. It is justifiable to move them into a
separate function. It also help the compiler inline compatible_argument_type()
if the slow path end up too big and complicate to inline.

From the code reading point of view, I found it helps to clearly separate the
simple hot path and the complicate slow path.

Again, it is your call. I will not enforce it.

Chris
