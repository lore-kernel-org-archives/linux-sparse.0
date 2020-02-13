From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: introduce sym_is_local() for reporter
Date: Thu, 13 Feb 2020 18:41:30 +0100
Message-ID: <20200213174130.vzc3tj3l3dj3xrpc@ltop.local>
References: <20200211160136.GA14027@redhat.com>
 <20200212004135.cyzcqtwwcuewa4gj@ltop.local>
 <20200212090626.GA19406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMRle (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Feb 2020 12:41:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so7732607wrs.12
        for <linux-sparse@vger.kernel.org>; Thu, 13 Feb 2020 09:41:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200212090626.GA19406@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Feb 12, 2020 at 10:06:27AM +0100, Oleg Nesterov wrote:
> On 02/12, Luc Van Oostenryck wrote:
> > It depends on what exactly you want for 'local'.
> 
> Yes, it should only return T if the symbol was defined inside some function.
> If we have
> 
> 	static int I;
> 
> in file scope, sym_is_local() should return false and so it does, test-dissect
> outputs
> 
> 	1:12                   def   v I                                int

OK, then everything is fine.
 
> Thanks for looking!

You're welcome!
This and the other pending ones are now pushed to main.

-- Luc
