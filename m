From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: Moving smatch to use sparse
Date: Thu, 5 Oct 2006 02:49:36 -0700
Message-ID: <a63d67fe0610050249j1cadc3bfk438b66ec8ad34586@mail.gmail.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>
	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
	 <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
	 <20061005092656.GA17866@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:41112 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751299AbWJEJti (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 05:49:38 -0400
Received: by ug-out-1314.google.com with SMTP id o38so166245ugd
        for <linux-sparse@vger.kernel.org>; Thu, 05 Oct 2006 02:49:37 -0700 (PDT)
In-Reply-To: <20061005092656.GA17866@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: smatch-discuss@lists.sf.net, linux-sparse@vger.kernel.org

On 10/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thu, Oct 05, 2006 at 01:41:03AM -0700, Dan Carpenter wrote:
> > Work on smatch is going ahead.  I have one real life check is working
> > and I've added a patched up the core code quite a bit.
>
> For the mindless - can you please repeat what smatch does?
>
>         Sam
>

It's a static code checker.  Take a look at check_null_deref.c.

You've got a function called match_assign() that gets called for every
assignment:

       name = get_variable_from_expr(expr->left, &sym);
       name = alloc_string(name);
       if (is_null(expr->right))
               set_state(name, my_id, sym, ISNULL);
       else
               set_state(name, my_id, sym, NONNULL);

Say it encounter the code:  a = foo(), then it's going to set the
state of 'a' to NONNULL;

Then say it encounters a call to tty_ldisc_deref(), it's going to
check the state of 'a' and if it's ISNULL or UNDEFINED it's going to
print a message out.

More often you have something like:
a = NULL;
if (b) {
       a = foo();
}
a->x;  <---Error.  'a' is Undefined.

The idea is that it's easy to write checks once all the state tracking
code is in place.

Use it like this:
make C=1 CHECK=/path/to/smatch > warns.out 2>&1

regards,
dan carpenter
