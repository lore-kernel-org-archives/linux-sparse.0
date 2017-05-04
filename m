From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: bit-field notation and k&r function syntax
Date: Thu, 4 May 2017 17:07:25 +0200
Message-ID: <20170504150724.p44fwdmnldq2bcyw@ltop.local>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
 <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
 <20170503230721.vb4aunmpaa2xxaf2@desk.local>
 <CANeU7Qn+R5auoxi=-==W+uExRfE7wRc7pfK-5OcENVEaB1-9Hw@mail.gmail.com>
 <20170504021406.abel7cm25x6fazkh@ltop.local>
 <CANeU7Qkq5GxOTUJE9Zqd_DjzBf2xeUadtUHii4G6Jt2GWcEseA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36009 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbdEDPH2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 11:07:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id u65so21666110wmu.1
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 08:07:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkq5GxOTUJE9Zqd_DjzBf2xeUadtUHii4G6Jt2GWcEseA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 03, 2017 at 11:20:24PM -0400, Christopher Li wrote:
> On Wed, May 3, 2017 at 10:14 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Yes, but there are a few details we need to look at.
> > For example, this should be supported (GCC does)
> >         int foo(a)
> >                 register int a;
> >         {
> >                 return a;
> >         }
> >
> > But this we should warn on this
> >         struct s {
> >                 register int a;
> >         };
> > And currently, we don't.
> 
> You are right. If we really want to fix that, we could add some field into
> "struct decl_state" to indicate we are in the struct mode, some storage
> specifier does not apply.
> 
> Can be a separate patch.

It's not that I care much about pre-ANSI syntax but this 'register' allowed
inside a struct really bugs me.

I'll look for a patchs in the coming days.

-- Luc
