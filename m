From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 0/2] drop the concept of 'known-but-ignored'
 attributes
Date: Thu, 15 Feb 2018 20:53:53 +0100
Message-ID: <20180215195351.ugvy6eqv2lcxdbbn@ltop.local>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
 <20180215155724.GB1882@localhost>
 <CA+55aFyWiRtNu+KK3h15hsy7Wt6VXK9ex3+gtJWbcqJ3WtyDrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55084 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033208AbeBOTxz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 14:53:55 -0500
Received: by mail-wm0-f52.google.com with SMTP id z81so2960973wmb.4
        for <linux-sparse@vger.kernel.org>; Thu, 15 Feb 2018 11:53:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFyWiRtNu+KK3h15hsy7Wt6VXK9ex3+gtJWbcqJ3WtyDrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>

On Thu, Feb 15, 2018 at 09:33:14AM -0800, Linus Torvalds wrote:
> On Thu, Feb 15, 2018 at 7:57 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > I absolutely agree that these have been annoying. However, they've also
> > been useful in the past to identify new flags used in the kernel and
> > other projects that we may need to actually act on, rather than just
> > ignore.
> 
> I think the issue is that the warning is useful for _sparse_
> developers, but not to actual users.
> 
> So I do think the warning itself should be off by default - but maybe
> the "known but ignored" table should exist so that sparse people can
> say "is there a new attribute that I need to look at"?

Yes, I think that the off by default is a clear thing. 
For the table, yes, I sort of agree with you and Josh at some level
but in practice I don't think it will be of any help. There is
already a number of attributes (and builtins) sparse *should* act on
(for attributes, I'm thinking to 'noreturn', for example) but haven't
and this for a long time already. I also think that once the warning
will be off by default, the table won't be updated anymore.

So, I'm not sure. I can't say I disagree but I can't say I'm
convinced it will be of any help.

-- Luc
