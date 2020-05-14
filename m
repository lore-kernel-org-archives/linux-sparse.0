From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] show-parse: null pointer dereference in do_show_type()
Date: Thu, 14 May 2020 23:14:17 +0200
Message-ID: <20200514211417.uibjj2jubdw754yk@ltop.local>
References: <20200511030620.10329-1-davidsondfgl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbgENVOU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 17:14:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9CC061A0C
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:14:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so586240wra.7
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:14:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200511030620.10329-1-davidsondfgl@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Davidson Francis <davidsondfgl@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, May 11, 2020 at 12:06:20AM -0300, Davidson Francis wrote:
> In do_show_type() the first if statement allows passing null
> pointers, which can cause a null pointer dereference in some
> cases, which I believe is not the desired behavior.
> 
> Fix this by changing the first if statement comparison.

Oh yes ...
Applied & pushed. Thanks.

-- Luc 
