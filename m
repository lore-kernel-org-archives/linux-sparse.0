From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse error on __int128
Date: Mon, 25 Jan 2016 18:47:04 +0100
Message-ID: <20160125174703.GA43281@macpro.local>
References: <55C9DD4F.9050805@redhat.com>
 <20160105000800.GA12116@macpro.local>
 <569659E9.1010703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36173 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbcAYRrO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 12:47:14 -0500
Received: by mail-wm0-f44.google.com with SMTP id l65so74061986wmf.1
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 09:47:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <569659E9.1010703@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Jan 13, 2016 at 09:06:33AM -0500, Tony Camuso wrote:
...

> >Now, of course, one could argue that sparse should also define __int128
> >on platforms where gcc define it, on x86_64 thus.

...

> So, I will apply the argument you so graciously supplied and posit that sparse
> should define __int128 on platforms where gcc defines it, e.g. x86_64. :)
> 
> It doesn't seem like a very intrusive change.


Hehe :)
Feel like writing a patch for it?

Luc
