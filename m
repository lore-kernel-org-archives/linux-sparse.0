From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Wed, 14 Jun 2017 04:05:40 +0200
Message-ID: <20170614020538.eve3b6y5di7edtuj@ltop.local>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
 <CANeU7QkJGdKuiBRw7mFHOh08TTOs=Au6vpgxBkN6LAyV5SvBtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34460 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdFNCFn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 22:05:43 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so20550404wrb.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 19:05:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkJGdKuiBRw7mFHOh08TTOs=Au6vpgxBkN6LAyV5SvBtg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 13, 2017 at 10:54:45AM -0700, Christopher Li wrote:
> On Mon, Jun 12, 2017 at 9:58 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I really think that for this it would be better to not have
> > this rc1 in a separate branch but instead a simple tag in
> > the master branch, like most projects do.
> 
> Done. I pushed to master with tag "v0.5.1-rc1".

Thanks.
 
> > Nothing really important but I would like to have the following
> > ones in the release:
> > - patch "avoid warning on explicit 'bool <- restricted' casts"
> >   I would have liked an Acked-by from Al Viro on this one but
> >   he is quite busy.
> > - patch "add support for -Wmemcpy-max-count" & friends
> >   This patch will likely be used for the git tree
> > - patch "finer control over error vs. warnings"
> >   which can reveal potential problems which were hidden
> > - patch "teach cgcc about OSX aka darwin"
> > - patch "ret-void: warn for implicit type"
> > - series "testsuite speedup"
> >
> > I'll send a pull request tomorrow.
> 
> Sounds good. I think I have review most of them already.
Not the 1st & 3rd here but nothing very special:
- 1st is the following of Al Viro's suggestion for the implicit case
  which now also do the same change for the explicit case
- 3rd untangle max_warnings and the fatc that an error has occurred.

> It should be a easy pull. I will create a RC2 after I pull from you.
Good.

-- Luc
