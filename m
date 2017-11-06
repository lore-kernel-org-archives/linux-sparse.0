From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
Date: Mon, 6 Nov 2017 16:43:35 +0100
Message-ID: <20171106154333.a5v6bji5u4gbuhn6@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
 <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52815 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbdKFPnk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 10:43:40 -0500
Received: by mail-wm0-f48.google.com with SMTP id t139so15159899wmt.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 07:43:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Nov 06, 2017 at 09:57:23AM +0100, Uwe Kleine-König wrote:
> Hello Luc,
> 
> > -local.mk
> > +.sparse.mk
> 
> what is the motivation to hide this file? IMHO it is better to be aware
> of eventual changes to the build system and so don't hide the file.
> 
> Having said that I question if it is a good idea at all to provide a way
> to change the build without dirtying the working copy.


I confess that this change is just for my own confort.
I often need to change change the CFLAGS while debugging or profiling.
I want that to be in a file, the file must of course not be under
version control and like .bashrc, kernel's .config or GCC's generated
.*.o.d files, I don't need to see this file and so I prefer it's an 
hidden one.

I understand your worries but since it's a file purposely changed
so that files are compiled differently, there is no surprises.
For dirtying the build ... yes, something could be done but really,
personnaly, I don't need this, I know when I need to clean my tree.

Regards,
-- Luc
