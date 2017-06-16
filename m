From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 10:08:18 -0700
Message-ID: <CANeU7QmU15CSvknUOT=FSaxLRAv5dnd7g5vXbLbmZKzbHzHLBg@mail.gmail.com>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local> <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34699 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdFPRIT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 13:08:19 -0400
Received: by mail-io0-f180.google.com with SMTP id i7so34013830ioe.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 10:08:19 -0700 (PDT)
In-Reply-To: <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 15, 2017 at 1:20 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> Please, drop what you have already pulled and take the
> following instead.

I am reviewing the pull request, here is some of the feed back for the memcpy
patch.

For -fmemcpy-max-count and -Wmemcpy-max-count, do we actually need to
have two separate options here? -fmemcpy-max-count set to zero will disable
this warning any way.

                unsigned long long val = count->value;
-               if (Wmemcpy_max_count && val > 100000ULL)
