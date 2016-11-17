From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/3] reduce noise from unknown attributes
Date: Thu, 17 Nov 2016 18:34:23 +0100
Message-ID: <20161117173422.GA25228@macpro.local>
References: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+ox=xjwOYeSMAOY8fxZUxsTioLMe=y_hUdBkG+qiWdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34252 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936256AbcKQRe0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:34:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so23454971wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:34:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=+ox=xjwOYeSMAOY8fxZUxsTioLMe=y_hUdBkG+qiWdg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 18, 2016 at 01:06:28AM +0800, Christopher Li wrote:
> On Thu, Nov 3, 2016 at 7:07 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Change from v1:
> >  - compile fix for a patch splitting leftover
> >  - each patch depends on the previous one
> 
> I fix the patch split in V1. Doe you have other change
> between the v1 and v2?

No. The issue with V1 was in fact only a last minute patch reordering.

Luc
