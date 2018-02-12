From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/9] add helpers for pseudo's user-list's size
Date: Mon, 12 Feb 2018 23:28:04 +0100
Message-ID: <20180212222802.cyr2iwtfjb4pli2o@ltop.local>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
 <20180212220246.17750-5-luc.vanoostenryck@gmail.com>
 <CA+55aFzwX8CKAeDuTwVg3MKa+LHXNaphi+mqoZE+2C7gaG61wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51629 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLW2H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:28:07 -0500
Received: by mail-wm0-f46.google.com with SMTP id r71so12441549wmd.1
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:28:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFzwX8CKAeDuTwVg3MKa+LHXNaphi+mqoZE+2C7gaG61wg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Feb 12, 2018 at 02:11:34PM -0800, Linus Torvalds wrote:
> On Mon, Feb 12, 2018 at 2:02 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Also add has_user(), a wrapper around the above that
> > can directly be used on a pseudo.
> 
> You add that wrapper, but then:
> 
> > -       if (ptr_list_size((struct ptr_list *) *list) == 0)
> > +       if (pseudo_user_list_size(*list) == 0)
> 
> you don't actually *use* it. That seems pointless.

Yes, I know it's not ideal.
My intention when I made has_users() was to use it too,
but I also made it to directly take a pseudo as argument
(which is the common case). And then when wanting to use
it I saw that there is pseudo here, only the pseudo_user_list.
So, I had to use the intermediate pseudo_user_list_size()
here instead of has_users().

I may change has_users() to take the user list instead
of the pseudo but my mental model was pseudos. 

-- Luc
