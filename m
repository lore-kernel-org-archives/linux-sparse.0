From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] pre-process: fix a compiler array subscript type warning
Date: Sat, 6 Jun 2020 01:09:53 +0200
Message-ID: <20200605230953.oe5pfjmpuvkxdkl3@ltop.local>
References: <fbb9ba2b-14fa-c6e1-a730-80d35547ea52@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgFEXJ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Jun 2020 19:09:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1993BC08C5C2
        for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2020 16:09:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q13so8693747edi.3
        for <linux-sparse@vger.kernel.org>; Fri, 05 Jun 2020 16:09:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fbb9ba2b-14fa-c6e1-a730-80d35547ea52@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Jun 05, 2020 at 10:29:24PM +0100, Ramsay Jones wrote:
> Hi Luc,
> 
> Having not done so in a while, last night I updated my cygwin
> installation. This resulted in updates to the versions of the
> libc/headers/gcc, among other things. (eg. gcc is now v9.3.0).
> 
> This patch fixes the new compiler warning that results!

Nice catch! I really hate the spec of these functions.

Thanks,
-- Luc
