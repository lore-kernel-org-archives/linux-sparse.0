Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFF3C433F5
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Mar 2022 08:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiC3IIN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Mar 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiC3IIJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Mar 2022 04:08:09 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA12E9C6;
        Wed, 30 Mar 2022 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nm3/83BLfTxqbB3yVdH7/M2MnTWGa1QQjPe4ZcE+AfI=;
  b=UX3JBE9liSJh7Y+T/Jw9kwqCp9Zx6vLskMGz+amWhPNDl5SlH6/MG1w+
   ubDYAppUXDwZFxOqCUYh7tzVyr2ANH5ptq3/pI4teqGMfPTPDHO0jwxS+
   pF63br6F2cX0DV7C4TTVldTld4Jk3GWrTjHystm+YZZEt6FYRe8hMAnZr
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,222,1643670000"; 
   d="scan'208";a="29030020"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:06:22 +0200
Date:   Wed, 30 Mar 2022 10:06:22 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
cc:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com, linux-doc@vger.kernel.org,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, dan.carpenter@oracle.com,
        julia.lawall@inria.fr
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
In-Reply-To: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203301005010.2592@hadrien>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

> +Strong points of Smatch and Coccinelle
> +--------------------------------------
> +
> +Coccinelle is probably the easiest for writing checks. It works before the
> +pre-compiler so it's easier to check for bugs in macros using Coccinelle.

pre-processor

> +Coccinelle also writes patches fixes for you which no other tool does.

writes patches fixes -> creates patches

> +
> +With Coccinelle you can do a mass conversion from

you can -> you can, for example,

julia

> +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> +that's really useful. If you just created a Smatch warning and try to push the
> +work of converting on to the maintainers they would be annoyed. You'd have to
> +argue about each warning if can really overflow or not.
> +
> +Coccinelle does no analysis of variable values, which is the strong point of
> +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> +way.
> --
> 2.35.1
>
>
