From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v1 02/28] misc: s/fntype/rettype/
Date: Wed, 20 May 2020 18:39:30 +0200
Message-ID: <20200520163930.3jfjgqhahupj5ill@ltop.local>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-3-luc.vanoostenryck@gmail.com>
 <0556fd1c-566d-3b3a-d760-418fecf115c0@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETQjd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 12:39:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5EC061A0E
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:39:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id yc10so4662363ejb.12
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:39:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0556fd1c-566d-3b3a-d760-418fecf115c0@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 20, 2020 at 01:35:13AM +0100, Ramsay Jones wrote:
> On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> > So, rename the variable holding the return type to 'rettype'
> > and only use 'fntype' for the one hoding the full function type.
> 
> s/hoding/holding/

Thanks for this and the ones in the other patches.
-- Luc 
