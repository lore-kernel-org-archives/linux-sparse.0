From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 5/7] arch: add specificities for Nios2
Date: Fri, 12 Jun 2020 19:04:48 +0200
Message-ID: <20200612170448.73ucdbgyuqkso5ta@ltop.local>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-6-luc.vanoostenryck@gmail.com>
 <3452bdc1-cc47-4f55-98ea-a84075e56c7e@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFLREv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Jun 2020 13:04:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7CC03E96F
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 10:04:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p18so6923626eds.7
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 10:04:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3452bdc1-cc47-4f55-98ea-a84075e56c7e@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Jun 12, 2020 at 02:04:50AM +0100, Ramsay Jones wrote:
> On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> > The real goal here is in fact to move the nios2-specfic
> > builtins out of the main builtins table.
> 
> I had to do a search for Nois II - do people actually run Linux
> on these? :-P

Yes, quite exotic! I also had to look about it.

> This and all remaining patches look good.

Thanks,
-- Luc
