From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/2] drop the concept of 'known-but-ignored' attributes
Date: Thu, 15 Feb 2018 09:33:14 -0800
Message-ID: <CA+55aFyWiRtNu+KK3h15hsy7Wt6VXK9ex3+gtJWbcqJ3WtyDrg@mail.gmail.com>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com> <20180215155724.GB1882@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:39148 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164907AbeBORdP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 12:33:15 -0500
Received: by mail-it0-f67.google.com with SMTP id l187so1487221ith.4
        for <linux-sparse@vger.kernel.org>; Thu, 15 Feb 2018 09:33:15 -0800 (PST)
In-Reply-To: <20180215155724.GB1882@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>

On Thu, Feb 15, 2018 at 7:57 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>
> I absolutely agree that these have been annoying. However, they've also
> been useful in the past to identify new flags used in the kernel and
> other projects that we may need to actually act on, rather than just
> ignore.

I think the issue is that the warning is useful for _sparse_
developers, but not to actual users.

So I do think the warning itself should be off by default - but maybe
the "known but ignored" table should exist so that sparse people can
say "is there a new attribute that I need to look at"?

                   Linus
