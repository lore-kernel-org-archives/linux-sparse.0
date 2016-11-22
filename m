From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] normalize bb's label names for testing
Date: Tue, 22 Nov 2016 18:02:31 +0100
Message-ID: <20161122170230.GA8847@macbook.local>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
 <20161122132748.GB8370@macbook.local>
 <CANeU7Qk+_N7A+DMKrLxoNi1fq8twfpJ8jLeartsc+jsMQiXN0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34224 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbcKVRTD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 12:19:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so5272241wme.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 09:19:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk+_N7A+DMKrLxoNi1fq8twfpJ8jLeartsc+jsMQiXN0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 23, 2016 at 12:44:36AM +0800, Christopher Li wrote:
> 
> It is private to the back end. If you consider test-linearize as one of
> the back end, it compile the C code into readable text form. it is fine
> to use it. I assume the label ID is only make sense for test-linearize,
> not for other back end?

I use it for test-linearize, test-unssa and others stuff I'll coming up
with in the coming weeks I hope. So nothing I consider as 'private',
external or out-of-tree.
 
> I am also OK with just introduce one more field ID for basic blocks.
> There are far less basic blocks than instructions. So even size of basic
> block bump up by a integer is not a big deal.
Yes, I think so too.
But anyway, I already sent a patch which reuse the 'priv' member with
an union. It will always be very easy to remove the union later if needed.
 
> > Sure.
> > But it should be noted that this filtering stuff *could* be useful for other
> > things to (but I have no such uses).
> 
> We can always deal with it when such usage actually come up.
Absolutely.

Luc
