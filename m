From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/5] add a method to external_declaration()
Date: Tue, 28 Feb 2017 10:46:36 +0100
Message-ID: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
 <20170218203048.22276-5-luc.vanoostenryck@gmail.com>
 <CANeU7Q=X66U4F1nGTdNH1q+mNF=JU9s8z=we0Gbpep4F6X-vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35685 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdB1Jr4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 04:47:56 -0500
Received: by mail-wm0-f53.google.com with SMTP id v186so80886808wmd.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 01:46:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=X66U4F1nGTdNH1q+mNF=JU9s8z=we0Gbpep4F6X-vgA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 27, 2017 at 11:37:09PM +0800, Christopher Li wrote:
> On Sun, Feb 19, 2017 at 4:30 AM, Luc Van Oostenryck wrote:
> >
> > This is what is needed for usual declarations but ignoring extern
> > symbols make it impossible to emit a diagnostic in less usual
> > situation.
> 
> I have other situation want to use this as well.

...

> So the struct symbol_list **list should turn into transparent argument as
> context for the call back.
> 

...

> I prefer here just provide the default call back which is
> add_stmt_decl in your case.

OK. I've made the changes related to this and also prepared
for something more generic (like the name of the method).

I've left the arg type as 'symbol_list **' for the moment though,
it will be easy enough to change when/if needed.

Luc 
