From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Handle SForced in storage_modifiers
Date: Mon, 14 Nov 2016 21:21:46 +0100
Message-ID: <20161114202145.GB15866@macbook.local>
References: <1479150736-28392-1-git-send-email-jlayton@redhat.com>
 <20161114200447.GA15866@macbook.local>
 <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36431 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbcKNUVu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 15:21:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so18644994wma.3
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 12:21:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 14, 2016 at 12:17:47PM -0800, Linus Torvalds wrote:
> On Mon, Nov 14, 2016 at 12:04 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > The array is statically initialized and never modified,
> > your patch shouldn't change anything, and this regardless of
> > the memory layout or compiler options.
> 
> The problem is the _size_ of the array. Without that initializer for
> SForced case, it is one entry too small, and you get a random access
> past the end of the array.
> 
> The patch is definitely correct.
> 
>               Linus
> --

Ah yes, indeed.

Thanks
