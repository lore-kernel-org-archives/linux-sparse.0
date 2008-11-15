From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: inline declaration and assignment
Date: Sat, 15 Nov 2008 15:20:27 +0300
Message-ID: <a63d67fe0811150420w55ff1c7arabe5e1a1083ea089@mail.gmail.com>
References: <Pine.NEB.4.64.0811102205210.20411@cesium.clock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:28423 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYKOMU2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 15 Nov 2008 07:20:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so777097yxm.1
        for <linux-sparse@vger.kernel.org>; Sat, 15 Nov 2008 04:20:27 -0800 (PST)
In-Reply-To: <Pine.NEB.4.64.0811102205210.20411@cesium.clock.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matt <matt@use.net>
Cc: linux-sparse@vger.kernel.org

The thing is that smatch is pretty much abandon-ware until Christmas
because I'm cycling through Africa and don't have a computer to work
with...  :/

On Tue, Nov 11, 2008 at 9:24 AM, Matt <matt@use.net> wrote:
> Hi,
>
> I'm playing with smatch and noticed that an inline assignment doesn't seem
> to get parsed as such. There's a couple of examples, but this one in
> sparse's own parse.c (line 1480) is probably the best:
>  struct ident *ident = NULL;
>
>
> sparse doesn't seem to identify this as an assignment, only a declaration.
> as a result, smatch gives this false positive:
> parse.c +1487 undefined param add_expression 1
>

I really wanted to polish smatch up and make it presentable before I left
but I ran out of time.

The message isn't an error message.  It's means that "ident" could either
be null or non-null depending on the if statement.

If add_expression() dereferenced the parameter without checking then
a message gets printed out there too.

There was supposed to be a script that made a list of all the functions
that were called with undefined parameters and a list of all the functions
that don't check.  If a parameter shows up on both lists then it's
possibly a bug.

cat out.txt | grep "undefined param" | cut -d ' ' -f 5- | sort -u > undefined
cat out.txt | grep unchecked | cut -d ' ' -f 5- | sort -u > unchecked
cat undefined unchecked | sort | uniq -c

As far as declarations go, in sparse the declaration expressions have an
initializer member if the expression is initialized.

The other thing is that you can use:
make C=y CHECK="smatch --debug" foo/bar.o

That will show you the states as they flow.

I guess the last thing is that the test assumes it is probably a bug
if you have:
if (foo) { ... } foo->bar;
But really there are too many macros and asserts that check this.
There are a lot of false positives from this script...

Maybe if we added two states arg_null and arg_non_null and
then changed these lines:

orig:
if (!tmp || tmp == &undefined || tmp == &isnull || tmp == &argument)
         set_true_false_states(name, my_id, sym, true_state, false_state);

new:
if (tmp == &undefined || tmp == &isnull)
         set_true_false_states(name, my_id, sym, true_state, false_state);
if (tmp == &argument)
         set_true_false_states(name, my_id, sym, arg_true, arg_false);

Then in merge_states():
if (s1 == &arg_false && s2 == &arg_true)
        return &argument;

There are some other places in the script that are affected...

Or you could just add some other allocator functions to the
return_null array.

Anyway.  Sorry again for the poor documentation and the rubbish
check script.  I'm probably not going to have email again for 2
weeks but if I can help let me know.

regards,
dan carpenter
bikesafari.net
