From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Tue, 15 Mar 2016 23:36:17 +0100
Message-ID: <20160315223616.GB2679@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38705 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbcCOWgV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 18:36:21 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so47298975wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 15:36:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87lh75jh9l.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:28:38AM +0100, Nicolai Stange wrote:
> Here comes the greatly enhanced v3 of this series.
> 


I had a few remarks and some questions in some of the patches
but I think it's turning pretty good.

I'm wondering if you have already tried to use it on something of
interesting size like the kernel? If yes, did it gave something useful?


Chris, I have reviewed this rather deeply. I think the approach is sound
and sane et the code seems quite correct. Do you think you will have
some time soon to look at it?


Regards,
Luc
