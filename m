From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] doc: correct some spelling
Date: Mon, 15 Jun 2020 00:05:30 +0200
Message-ID: <20200614220530.x4nr7zhlmxuk7zj7@ltop.local>
References: <a03299d8-fd2f-8f04-2bd0-e94091247bdb@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgFNWFd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 18:05:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF5C05BD43
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 15:05:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g1so10102635edv.6
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 15:05:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a03299d8-fd2f-8f04-2bd0-e94091247bdb@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jun 14, 2020 at 08:36:38PM +0100, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> 
> The only spelling fixes in the manpage are s/exemple/example/,
> s/trigered/triggered/ and s/&/and/. I would not normally change
> any 'formatting' in sparse.1, but the '{ 0 }' and '{ }' got
> split across line-endings, so I removed the spaces.
> (other solutions are possible ...)

Thank you again for noticing and fixing these typos.

Yes, the formatting is often very bad on the man page
because of bad or missing linebreaks.
I changed this part of your patch to use a non-breakable
space for the '{ 0 }' and '{ }'. They look, I think, better.

-- Luc
