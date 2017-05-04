From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 21:18:01 +0200
Message-ID: <20170504191800.hof26cp3zbpc4do4@ltop.local>
References: <20170504160038.5328-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37300 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755833AbdEDTSE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 15:18:04 -0400
Received: by mail-wm0-f44.google.com with SMTP id m123so4514786wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 12:18:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170504160038.5328-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Thu, May 04, 2017 at 12:00:38PM -0400, Lance Richardson wrote:
> This patch introduces support for the C11 _Static_assert() construct.

It's very good to me. Many thanks.

If needed here is my:
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I don't know how Chris will take it, for the moment I've taken the
liberty to add it to my dev tree with 3 small changes:
- there was a small conflict with 'master' and 'sparse-next'
- git am moaned about superfluous whitespaces
- I shuffled slightly the code to minimize changes around it
The result can be found at:
	https://github.com/lucvoo/sparse/tree/static-assert


-- Luc Van Oostenryck
