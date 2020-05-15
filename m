From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: complain about re-declared functions with different modifiers
Date: Fri, 15 May 2020 18:11:59 +0200
Message-ID: <20200515161159.esquifvwlcgtzirj@ltop.local>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
 <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
 <20200515133617.GF2078@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOQMD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 May 2020 12:12:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F61C061A0C
        for <linux-sparse@vger.kernel.org>; Fri, 15 May 2020 09:12:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w7so4130867wre.13
        for <linux-sparse@vger.kernel.org>; Fri, 15 May 2020 09:12:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200515133617.GF2078@kadam>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, May 15, 2020 at 04:36:17PM +0300, Dan Carpenter wrote:
> Yeah.  That's it.  When I see the call, I want to parse the statements
> so I need the symbol with the implementation.

OK, thanks. I'll look at this this WE. 

-- Luc
