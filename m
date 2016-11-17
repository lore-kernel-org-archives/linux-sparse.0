From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Thu, 17 Nov 2016 14:03:05 -0800
Message-ID: <CA+55aFwsQYAFO+hbSi3pxvkjVA6Jv=DpeZrVHyzj9-RmAuF=tQ@mail.gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com> <20161117202523.GA35194@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33478 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbcKQWDH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 17:03:07 -0500
Received: by mail-oi0-f51.google.com with SMTP id 128so69256907oih.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 14:03:06 -0800 (PST)
In-Reply-To: <20161117202523.GA35194@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Nov 17, 2016 at 12:25 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Would something like the following be fine?

This looks good to me, although I didn't actually test it.  But it
looks like what I would have expected.

Some of those inlines look large enough that I wonder how much sense
they make as inlines any more, but I think that's a separate issue.

               Linus
