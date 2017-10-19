From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 19:25:06 -0700
Message-ID: <CANeU7Q=L53pByr1a7iFj-hzvGb_kHiW92tpUgThyE9QeYdCbzg@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org> <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
 <1508358019.4628.35.camel@poochiereds.net> <CANeU7QnRU7EgQTX1DiDHQj7JZBeKs2ZAeHKKSJNQxhKPXwoKjA@mail.gmail.com>
 <1508377663.19876.20.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46011 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdJSCZH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 22:25:07 -0400
Received: by mail-yw0-f194.google.com with SMTP id j4so2296425ywb.2
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 19:25:07 -0700 (PDT)
In-Reply-To: <1508377663.19876.20.camel@poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 6:47 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>
> No, it wasn't intentional. Could we just turn that into a +=
> assignment?

No, turn that into += does not work either. The variable come from
command line has the $(origin varname) set to "command line".
make will ignore normal modification to that variable, including "+="

If you really need to make modification of that variable.
You need to use the "override" directive.

https://www.gnu.org/software/make/manual/make.html

     6.7 The override Directive

override CFLAGS += "...."

For that reason, I would suggest using a different variable
to assign from the command line.

>
> Got it, thanks. Basically I just need a way to pass in a basic set of
> flags to gcc, that are either appended or prepended to whatever you
> need to have in there. If we need to call it something other than
> CFLAGS, then that's fine.

Right. Given any makefile, I can always pick some internal variable,
assign that variable from command line, then the make process does
not work as intended. In our case, CFLAGS is such a variable.

I would suggest have one variable like CFLAGS_CMD to get
overwrite from command line. You can suggest the variable name.

You should also examine your rpmbuild script for other open
source packages. Weather they suffer from the same CFLAGS overwrite
problems.

Again, patch is welcome.

Chris
