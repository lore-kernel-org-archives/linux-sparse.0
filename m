From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Fri, 18 Nov 2016 01:29:19 +0100
Message-ID: <20161118002918.GA35373@macpro.local>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
 <20161117202523.GA35194@macpro.local>
 <CA+55aFwsQYAFO+hbSi3pxvkjVA6Jv=DpeZrVHyzj9-RmAuF=tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36017 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbcKRA3X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 19:29:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so921742wma.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 16:29:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFwsQYAFO+hbSi3pxvkjVA6Jv=DpeZrVHyzj9-RmAuF=tQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Nov 17, 2016 at 02:03:05PM -0800, Linus Torvalds wrote:
> On Thu, Nov 17, 2016 at 12:25 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Would something like the following be fine?
> 
> This looks good to me, although I didn't actually test it.  But it
> looks like what I would have expected.
> 
> Some of those inlines look large enough that I wonder how much sense
> they make as inlines any more, but I think that's a separate issue.

Oh, I absolutely agree.
What I would like is something more iterator oriented which keep track
of the head-list-nr state. I have a working prototype I made last week
but it still needs some more polishing.

Luc
