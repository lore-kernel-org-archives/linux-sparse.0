From: Christopher Li <sparse@chrisli.org>
Subject: Re: bit-field notation and k&r function syntax
Date: Wed, 3 May 2017 23:20:24 -0400
Message-ID: <CANeU7Qkq5GxOTUJE9Zqd_DjzBf2xeUadtUHii4G6Jt2GWcEseA@mail.gmail.com>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
 <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
 <20170503230721.vb4aunmpaa2xxaf2@desk.local> <CANeU7Qn+R5auoxi=-==W+uExRfE7wRc7pfK-5OcENVEaB1-9Hw@mail.gmail.com>
 <20170504021406.abel7cm25x6fazkh@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36998 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932581AbdEDDUZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 23:20:25 -0400
Received: by mail-it0-f50.google.com with SMTP id x188so1555432itb.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 20:20:25 -0700 (PDT)
In-Reply-To: <20170504021406.abel7cm25x6fazkh@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 3, 2017 at 10:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, but there are a few details we need to look at.
> For example, this should be supported (GCC does)
>         int foo(a)
>                 register int a;
>         {
>                 return a;
>         }
>
> But this we should warn on this
>         struct s {
>                 register int a;
>         };
> And currently, we don't.

You are right. If we really want to fix that, we could add some field into
"struct decl_state" to indicate we are in the struct mode, some storage
specifier does not apply.

Can be a separate patch.

Chris
