From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse release v0.5.1-rc1
Date: Tue, 13 Jun 2017 10:54:45 -0700
Message-ID: <CANeU7QkJGdKuiBRw7mFHOh08TTOs=Au6vpgxBkN6LAyV5SvBtg@mail.gmail.com>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37079 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbdFMRyw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 13:54:52 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so42082751iti.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 10:54:46 -0700 (PDT)
In-Reply-To: <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 12, 2017 at 9:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I really think that for this it would be better to not have
> this rc1 in a separate branch but instead a simple tag in
> the master branch, like most projects do.

Done. I pushed to master with tag "v0.5.1-rc1".

> Nothing really important but I would like to have the following
> ones in the release:
> - patch "avoid warning on explicit 'bool <- restricted' casts"
>   I would have liked an Acked-by from Al Viro on this one but
>   he is quite busy.
> - patch "add support for -Wmemcpy-max-count" & friends
>   This patch will likely be used for the git tree
> - patch "finer control over error vs. warnings"
>   which can reveal potential problems which were hidden
> - patch "teach cgcc about OSX aka darwin"
> - patch "ret-void: warn for implicit type"
> - series "testsuite speedup"
>
> I'll send a pull request tomorrow.

Sounds good. I think I have review most of them already.
It should be a easy pull. I will create a RC2 after I pull from you.

Thanks for the great work.

Chris
