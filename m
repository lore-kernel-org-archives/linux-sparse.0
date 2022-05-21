Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E707C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 12:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiEUMcX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiEUMcW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 08:32:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7959C2E7
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 05:32:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n13so18130266ejv.1
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ApmdoJdNC3KDvIHarKSNG4M2dxEb2wO9QWwoNQ8oWc=;
        b=Cr+N7WHEUrh3ZzJSOG5PE5Ajv0clWv4ODaS58QFzrL4FkmJDrgVxonjGsEgbrMv7Dy
         /VZzhP2vdpbUMp22e7M7rqGhXBHgDMIIBqiVD7jE/mAy0Z1szGmTpsVRK6fLqy5oTfDS
         BZNZaExrYEw3T3bkQRnV66Y2qJJB9JKh/Go7txtk3XsN5ZHMlH8gWFh3un3uwOBqTTcx
         emSzK9N342xbVBCgT3c5W86ObGnHzZzxR38T4peT9tLywHX2NLirAQ9qsSeWD7Bi+tXx
         nk0mnqrb7O+KHOWg+iMid/KAZiDVBuIFZdU3Vt7J2EvIIOnbkUM5xkx0Ef2+fu7JY63V
         8PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ApmdoJdNC3KDvIHarKSNG4M2dxEb2wO9QWwoNQ8oWc=;
        b=r2kgrkPUE9yPcBTcL5Z9duZf15xPyQUvg2F/YyBpZL4N8FFE0KtunAf3QBa+lDrIYy
         +1wvPxbAyP7rFnnPL56yi/I0603RwApSjmXjUb6EBLCmbscEZRtRI3jNouW+deaNW3Ud
         c7kRzglpGsh/BX01vOCVKXu/PKIqSuB/Tu9+BtLckBZQ1ZTPfteaUd3a1b92AEykYSxx
         fFdSpV0VgEOe0wmbGqv1/hOWbczgL9V9ys3RQkwgDLIgNRKrXXbFHSiWuzHUC6acCRGm
         0nT5zR9dXj13cmeAAMTxJw16rbK5b9WvJkZUXN9XQLzgiOLqwG/ylE5Lt5UZaX5gqucE
         8Oxw==
X-Gm-Message-State: AOAM532KJO7dDOCEfrUY3q7mKWzBO3+K9G+dm+ld+/y3A6ejnyE4JC+V
        WkZnouCoTIOHihgrkgjWBs+PF0JP+GY=
X-Google-Smtp-Source: ABdhPJx3f04gqc7KT1VfSxz6MLVW/ACUq/EmDK0Rq08+M5Pe0IaBzis4xFglC+jh07ETr6bFV6MA0Q==
X-Received: by 2002:a17:907:7205:b0:6f5:3f1:927e with SMTP id dr5-20020a170907720500b006f503f1927emr12545828ejc.739.1653136339529;
        Sat, 21 May 2022 05:32:19 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id f26-20020a50fe1a000000b0042617ba63c9sm5727622edt.83.2022.05.21.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:32:18 -0700 (PDT)
Date:   Sat, 21 May 2022 14:32:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sparse: only warn about directly nested flexible arrays
Message-ID: <20220521123218.6b455ktbumrgao6i@mail>
References: <20220111233959.2301120-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111233959.2301120-1-jacob.e.keller@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jan 11, 2022 at 03:39:59PM -0800, Jacob Keller wrote:

Hi,

Sorry for this long delay.

> Commit 02ed28909f3b ("flex-array: warn on flexible array in nested
> aggregate types") Introduced a new -Wflexible-array-nested warning which
> produces a warning when code nests a flexible array aggregate type
> within another aggregate type.
> 
> This can produce warnings that are difficult to understand if this
> becomes nested. Consider the following example code:
> 
> struct a {
>   int i;
>   long f[];
> };
> 
> struct b {
>   struct a a;
> };
> 
> struct c {
>   struct b b;
> };
> 
> This will produce a warning both at struct b which directly embeds the
> struct a, and also at c which happens to include struct a recursively.
> 
> It does not make sense to warn at the site of struct c. We already
> produce a warning at struct b! This just confuses users and can produce
> lots of extra warnings. Consider if struct b was part of some header
> and all of its users now see warnings for their usages like 'struct c'
> which now look like their fault, when the fault really lies with the
> definition of struct b.
> 
> To avoid this, stop proliferating has_flexible_array so that the outer
> struct no longer produces a warning.

I fully agree with the feeling here but your patch would also disable
a warning for:
	struct s_flex {
		int i;
		long f[];
	};
	
	union s {
		struct s_flex flex;
		char buf[200];
	};
	
	static union s a[2];

and catching arrays containing some flexible-array-member was one of
reasons to add the warning.

 
> This patch is a response to my query at
> https://lore.kernel.org/linux-sparse/64238376-3882-2449-7758-e948cb4a6e1c@intel.com/T/#u

I don't agree with everything you wrote there. For example, something like
"zero-sized flexible member" is meaningless to me (at least from a type
system PoV, which is what Sparse is all about) because a FAM has no (static)
size. It's just that struct tty_bufhead::sentinel.data will not (and must not!)
be used, but this won't be checkable.

> I think that proliferating this warning is unnecessary (since it will
> produce one warning at the exact point where we embed the structure already)
> and avoids confusing users of a header into thinking their code is at fault
> when its the code in the header at fault.

Yes, I  fully agree.
I'll see in the coming days what can be done.
 
-- Luc
