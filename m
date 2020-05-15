From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: complain about re-declared functions with different modifiers
Date: Fri, 15 May 2020 18:18:05 +0200
Message-ID: <20200515161805.3xcxg3woquhbpspc@ltop.local>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
 <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
 <CAHk-=wh_1ycEjZGN+qFBP8==XPF-+wsiyJ0=-J5JSMDMxmo32g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOQSI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 May 2020 12:18:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538EC061A0C
        for <linux-sparse@vger.kernel.org>; Fri, 15 May 2020 09:18:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l11so4272183wru.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 May 2020 09:18:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_1ycEjZGN+qFBP8==XPF-+wsiyJ0=-J5JSMDMxmo32g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 14, 2020 at 03:32:38PM -0700, Linus Torvalds wrote:
> 
> And gcc refuses to compile it with
> 
>    error: redefinition of ‘a’
> 
> which is admittedly very sane.
> 
> So I think sparse is in the wrong here, and we should consider both
> external and static symbols to be in the same scope and conflict with
> each other unless their declarations match.

Yes, I agree. I'll see what can be done for this.

-- Luc
