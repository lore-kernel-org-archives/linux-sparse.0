From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] fix: evaluate_dereference() unexamined base type
Date: Sun, 26 Nov 2017 20:18:59 +0100
Message-ID: <20171126191858.l65yp5qevi6iwi6t@ltop.local>
References: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
 <20171125093115.95791-3-luc.vanoostenryck@gmail.com>
 <CANeU7QkDYorh5B=5nJ8sQjzvJcwHuzv+hjM3bAFtG90k2_1AxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:45905 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdKZTTD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Nov 2017 14:19:03 -0500
Received: by mail-wm0-f46.google.com with SMTP id 9so30231767wme.4
        for <linux-sparse@vger.kernel.org>; Sun, 26 Nov 2017 11:19:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkDYorh5B=5nJ8sQjzvJcwHuzv+hjM3bAFtG90k2_1AxA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 27, 2017 at 01:48:01AM +0800, Christopher Li wrote:
> On Sat, Nov 25, 2017 at 5:31 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Examination of a pointer type doesn't examine the corresponding base type
> > (this base type maybe not yet be complete).
> > The examination of thz base type must thus be done later.
> >
> > However, in some cases (maybe only when typeof() is involved) it's
> > possible to call evaluate_dereference() while the base type is still
> > unexamined.
> >
> > Fix this by adding the missing examine_symbol_type() on the base type.
> 
> The changes looks fine to me.

But better to hold now for now.
I *think* the change is correct but things are a bit muddy
there and it triggers another, more annoying, bug.

-- Luc
