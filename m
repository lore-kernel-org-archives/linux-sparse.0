From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 0/2] drop the concept of 'known-but-ignored'
 attributes
Date: Thu, 15 Feb 2018 21:03:10 +0100
Message-ID: <20180215200308.p73mag77qpiebalr@ltop.local>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
 <20180215155724.GB1882@localhost>
 <CA+55aFyWiRtNu+KK3h15hsy7Wt6VXK9ex3+gtJWbcqJ3WtyDrg@mail.gmail.com>
 <20180215175402.GA6236@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35820 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033802AbeBOUDP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 15:03:15 -0500
Received: by mail-wr0-f175.google.com with SMTP id l43so889616wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 15 Feb 2018 12:03:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180215175402.GA6236@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>

On Thu, Feb 15, 2018 at 09:54:02AM -0800, Josh Triplett wrote:
> On Thu, Feb 15, 2018 at 09:33:14AM -0800, Linus Torvalds wrote:
> > On Thu, Feb 15, 2018 at 7:57 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> > >
> > > I absolutely agree that these have been annoying. However, they've also
> > > been useful in the past to identify new flags used in the kernel and
> > > other projects that we may need to actually act on, rather than just
> > > ignore.
> > 
> > I think the issue is that the warning is useful for _sparse_
> > developers, but not to actual users.
> 
> Unless they're debugging why Sparse doesn't fully understand their code,
> yes.
> 
> > So I do think the warning itself should be off by default - but maybe
> > the "known but ignored" table should exist so that sparse people can
> > say "is there a new attribute that I need to look at"?
> 
> Agreed on both counts.
> 
> I also wonder if it might make sense to make "unknown attribute" a
> warning that automatically gets displayed *if* displaying other warnings
> at the same time, to help with debugging the other warnings. That way,
> if you run Sparse on a file that would otherwise produce no warnings, an
> unknown attribute doesn't create noise; however, if you run Sparse on a
> file that would give warnings anyway, you get the unknown attribute
> warning as well, which might make it obvious why the other warnings
> arise.
> 
> For instance, if you see Sparse warn about an unknown attribute on a
> type, followed by a pile of type mismatches involving that type, perhaps
> you'd want to investigate that attribute and its use.

Yes, that would be an idea. It's a bit annoying to implement though,
unknown attributes is something detected at parsing time, while type
errors are done later.

OTOH, there are other situations where postponing a warning would
also be something useful, so ...

-- Luc
