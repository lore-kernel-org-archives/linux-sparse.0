From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Thu, 29 Jun 2017 09:04:38 +0200
Message-ID: <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36171 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdF2HEl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 03:04:41 -0400
Received: by mail-wm0-f49.google.com with SMTP id 62so73167951wmw.1
        for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2017 00:04:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 27, 2017 at 10:21:43AM -0700, Christopher Li wrote:
> I notice this unknow attribute "__optimize__"when I am looking
> sparse checking result on the recent kernel compile.

There is also a long time 'require_context' in drivers/block/drbd,/
a failed attempt to fix or extend sparse's handling of lock context.
Why is it still there after all those years, I have no idea.
 
Anyway, my position about these unknown attributes is still the same
of course: we should simply ignore them instead of annoying people
with useless warnings.

-- Luc
