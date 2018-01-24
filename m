From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: should we document more command line options
Date: Wed, 24 Jan 2018 21:08:07 +0100
Message-ID: <20180124200806.bembuf4agxbzjtcj@ltop.local>
References: <23350ab8-06a9-5b09-2409-358d33219679@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39185 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeAXUIL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 15:08:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id b21so10910273wme.4
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 12:08:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <23350ab8-06a9-5b09-2409-358d33219679@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jan 24, 2018 at 11:47:21AM -0800, Randy Dunlap wrote:
> I suppose that we could just add something in the general DESCRIPTION paragraph
> like:
> 
>   Besides the options listed below, sparse also accepts many C compiler command
>   line options.
> 
> but that's not very helpful (at least to me).  For my use, I made a short text
> file of other (not documented in sparse.1) command line options.  Should these
> be added to sparse.1 or elsewhere or not at all?  (Of course, some of these
> could be incorrect. :)

It seems that until now, the only options that were documented were
the ones specific to sparse, in other words the ones that are not
present in GCC. I suppose the rationale was that it is wasn't
needed since the aim is to be GCC compatible.
But of course, a lot of existing GCC options are simply ignored
by sparse, so yes, it may be interesting to know which options
are really implemented but their effect and this their description
should normally be the same in GCC.
 
-- Luc
