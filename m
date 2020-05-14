From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: fix LLVM version detection
Date: Thu, 14 May 2020 23:10:03 +0200
Message-ID: <20200514210908.74w6gzgdotigx4ns@ltop.local>
References: <20200420155352.11364-1-quentin@isovalent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgENVKH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 17:10:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2679C061A0C
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:10:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so520244wrp.12
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:10:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200420155352.11364-1-quentin@isovalent.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Quentin Monnet <quentin@isovalent.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 20, 2020 at 04:53:52PM +0100, Quentin Monnet wrote:
> The regex match used for detecting the LLVM version works for versions
> with a single-digit major number. Now that LLVM v10 is out, detection
> can fail, resulting in sparse-llvm not being built.
> 
> Fix detection by extracting the major version number to compare with the
> minimum supported.

Sorry for the late reply.
Applied & pushed. Thanks.

-- Luc
